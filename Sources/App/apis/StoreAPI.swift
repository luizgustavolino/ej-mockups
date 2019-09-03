//
//  Store.swift
//  App
//
//  Created by luiz gustavo lino on 14/08/19.
//

import Foundation
import Vapor

public struct StoreAPI {
    
    public let request:Request
    
    public init(_ request:Request) {
        self.request = request
    }
    
    public func stats() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            do {
                
                let legacy  = try self.legacyStore()
                let encoded = try JSONEncoder().encode(legacy.asStats)
                let encodedJSON = String(data: encoded, encoding: .utf8)
                promise.succeed(result: encodedJSON!)
                
            } catch {
                print("Failing: \(error)")
                promise.fail(error: error)
            }
        }
        return promise.futureResult
    }
    
    public func store() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            do {
                
                let legacy  = try self.legacyStore()
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
    
    private func legacyStore() throws -> LegacyStore {
        let client = try HTTPClient.connect(scheme: .https,
                                            hostname: "www.enjoei.com.br",
                                            on: self.request).wait()
    
        let store   = try self.request.parameters.next(String.self)
        let path    = "/api/v3/users/@\(store)"
        let httpReq = HTTPRequest(method: .GET, url: path)
    
        let httpRes = try client.send(httpReq).wait()
        let data    = httpRes.body.data!
        let legacy  = try JSONDecoder().decode(LegacyStore.self, from: data)
        return legacy
    }
}
