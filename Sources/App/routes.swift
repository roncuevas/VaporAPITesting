import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        req.description
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("randomuser") { req in
        req.client.get(URI(string: "https://randomuser.me/api/")).flatMap { response in
            return response.encodeResponse(for: req)
        }
    }
    
    let protected = app.grouped(UserAuthenticator())
    protected.get("me") { req -> String in
        try req.auth.require(User.self)
        return "El nombre es \(String(describing: req.auth.get(User.self)?.name))"
    }
    
    try app.register(collection: TodoController())
}

struct UserAuthenticator: AsyncBearerAuthenticator {
    typealias User = App.User

    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
       if bearer.token == "foo" {
           request.auth.login(User(name: "Vapor"))
       }
   }
}

struct User: Authenticatable {
    var name: String
}

