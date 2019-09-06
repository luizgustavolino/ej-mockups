import App
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.get("api", "store", String.parameter, "stats") { request in
    return StoreAPI(request).stats()
}

router.get("api", "store", String.parameter) { request in
    return StoreAPI(request).store()
}

router.get("api", "products", Int.parameter) { request in
    return ProductAPI(request).show()
}

try app.run()
