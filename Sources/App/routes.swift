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
    
    try app.register(collection: TodoController())
}
