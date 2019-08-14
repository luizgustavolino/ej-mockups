import App
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.get("store", String.parameter) { request in
    return Store(request).render()
}

try app.run()
