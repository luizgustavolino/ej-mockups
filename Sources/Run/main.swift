import App
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.get("store") { request in
    return Store(request).render()
}


//func getLegacyStore() -> String {
//    let worker = MultiThreadedEventLoopGroup(numberOfThreads: 2)
//    let client = try? HTTPClient.connect(hostname: "www.enjoei.com.br", on: worker).wait()
//    let httpReq = HTTPRequest(method: .GET, url: "/api/v3/users/dixie/")
//    let httpRes = try? client?.send(httpReq).wait()
//    return "\(httpRes)"
//}
//
//router.get("store") { req in
//    func a(){
//        let promise = req.eventLoop.newPromise(String.self)
//        print(promise)
//    }
//    return getLegacyStore()
//}

try app.run()
