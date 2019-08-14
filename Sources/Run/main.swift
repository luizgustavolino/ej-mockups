import App
import Vapor

let app = try Application()
let router = try app.make(Router.self)

router.get("hello") { req in
    return "Hello, world! funciona mesmo ae"
}

try app.run()
