import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let dbController = UserController()
    let protected = app.grouped(UserAuthenticator())
    let middleWare = app.grouped(UserAuthenticator())
    
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
    
    app.get("sample_airbnb") { req async throws -> [ListingsAndReviewsModel] in
        return try await ListingsAndReviewsModel.query(on: req.db(.init(string: "sample_airbnb"))).all()
    }
    
    protected.get("allusers") { req async throws -> [UserModel] in
        try req.auth.require(UserAuthenticatable.self)
        return try await dbController.index(req: req)
    }
    
    protected.get("me") { req -> String in
        try req.auth.require(UserAuthenticatable.self)
        return "El nombre es \(String(describing: req.auth.get(UserAuthenticatable.self)?.name))"
    }
    
    try app.register(collection: UserController())
}
