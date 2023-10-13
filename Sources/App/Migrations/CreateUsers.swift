import Fluent

struct CreateUsers: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("access")
            .id()
            .field("user", .string)
            .field("password", .string)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("access").delete()
    }
}
