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
                let store   = try self.request.parameters.next(String.self)
                let url     = URL(string: "https://www.enjoei.com.br/api/v3/users/\(store)")!
                let json    = try Data(contentsOf: url)
                let legacy  = try JSONDecoder().decode(LegacyStore.self, from: json)
                let encoded = try JSONEncoder().encode(legacy.asStore)
                let encodedJSON = String(data: encoded, encoding: .utf8)
                promise.succeed(result: encodedJSON!)
            } catch {
                promise.fail(error: error)
            }
        }
        return promise.futureResult
    }
}
