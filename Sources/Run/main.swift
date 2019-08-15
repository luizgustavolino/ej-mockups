import App
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.get("api", "store", "counters", String.parameter) { request in
    return StoreAPI(request).counters()
}

router.get("api", "store", String.parameter) { request in
    return StoreAPI(request).store()
}

try app.run()
