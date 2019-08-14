import Vapor


public struct Store{
    
    public let request:Request
    
    public init(_ request:Request) {
        self.request = request
    }
    
    public func render() -> String {
        return "hello Store requester: \(request)"
    }
}
