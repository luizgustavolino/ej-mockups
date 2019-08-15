import Vapor

public struct StoreAPI {
    
    public let request:Request
    
    public init(_ request:Request) {
        self.request = request
    }
    
    public func render() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            do {
                
                let client = try HTTPClient.connect(scheme: .https,
                                                    hostname: "www.enjoei.com.br",
                                                    on: self.request).wait()
                
                let store   = try self.request.parameters.next(String.self)
                let path    = "/api/v3/users/@\(store)"
                let httpReq = HTTPRequest(method: .GET, url: path)
                
                let httpRes = try client.send(httpReq).wait()
                let data    = httpRes.body.data!
                
                let legacy  = try JSONDecoder().decode(LegacyStore.self, from: data)
                let encoded = try JSONEncoder().encode(legacy.asStore)
                let encodedJSON = String(data: encoded, encoding: .utf8)
                
                promise.succeed(result: encodedJSON!)
                
            } catch {
                print("Failing: \(error)")
                promise.fail(error: error)
            }
        }
        return promise.futureResult
    }
}
