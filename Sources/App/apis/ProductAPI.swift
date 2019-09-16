//
//  ProductAPI.swift
//  App
//
//  Created by Luiz Gustavo Lino on 6/Sep/19.
//

import Foundation
import Vapor 

public struct ProductAPI {

    public let request:Request

    public init(_ request:Request) {
        self.request = request
    }

    public func show() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            do {

                let legacy  = try self.legacyProduct()
                let encoded = try JSONEncoder().encode(legacy.asProduct())
                let encodedJSON = String(data: encoded, encoding: .utf8)
                promise.succeed(result: encodedJSON!)

            } catch {
                print("Failing: \(error)")
                promise.fail(error: error)
            }
        }
        return promise.futureResult
    }

    public func count() -> EventLoopFuture<String> {
        let promise = self.request.eventLoop.newPromise(String.self)
        DispatchQueue.global().async {
            do {
                
                let legacy  = try self.legacyProduct()
                let encoded = try JSONEncoder().encode(legacy.comments)
                let encodedJSON = String(data: encoded, encoding: .utf8)
                promise.succeed(result: encodedJSON!)
                
            } catch {
                print("Failing: \(error)")
                promise.fail(error: error)
            }
        }
        return promise.futureResult
    }
    
    private func legacyProduct() throws -> LegacyProductModel {
        let client = try HTTPClient.connect(scheme: .https,
                                            hostname: "www.enjoei.com.br",
                                            on: self.request).wait()

        let product = try self.request.parameters.next(Int.self)
        let path    = "/api/products/\(product)?version=1"
        let httpReq = HTTPRequest(method: .GET, url: path)

        let httpRes = try client.send(httpReq).wait()
        let data    = httpRes.body.data!
        let legacy  = try JSONDecoder().decode(LegacyProductModel.self, from: data)
        return legacy
    }
}
