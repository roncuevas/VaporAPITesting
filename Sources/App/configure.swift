import NIOSSL
import Fluent
import FluentMongoDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    try app.databases.use(.mongo(
        connectionString: MongoConstatns.connectionString
    ), as: .mongo)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUsers())

    // register routes
    try routes(app)
}
