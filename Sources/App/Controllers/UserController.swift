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

    func index(req: Request) async throws -> [UserModel] {
        try await UserModel.query(on: req.db(.users)).all()
    }

    func create(req: Request) async throws -> UserModel {
        let user = try req.content.decode(UserModel.self)
        try await user.save(on: req.db(.users))
        return user
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let user = try await UserModel.find(req.parameters.get("usersID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await user.delete(on: req.db(.users))
        return .noContent
    }
}
