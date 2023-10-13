import Fluent
import Vapor

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let users = routes.grouped("users")
        users.get(use: index)
        users.post(use: create)
        users.group(":usersID") { user in
            user.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [UserAccess] {
        try await UserAccess.query(on: req.db).all()
    }

    func create(req: Request) async throws -> UserAccess {
        let user = try req.content.decode(UserAccess.self)
        try await user.save(on: req.db)
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await UserAccess.find(req.parameters.get("usersID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db)
        return .noContent
    }
}
