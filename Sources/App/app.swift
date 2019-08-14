import Vapor


public struct Store{
    
    public let request:Request
    
    public init(_ request:Request) {
        self.request = request
    }
    
    public func render() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            let store = try! self.request.parameters.next(String.self)
            let url  = URL(string: "https://www.enjoei.com.br/api/v3/users/\(store)")!
            let json = try! Data(contentsOf: url)
            let string = String(data: json, encoding: .utf8)
            promise.succeed(result: string!)
        }
        return promise.futureResult
    }
}
