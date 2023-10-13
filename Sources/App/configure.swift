import NIOSSL
import Fluent
import FluentMongoDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    try app.databases.use(.mongo(
        connectionString: MongoConstatns.connectionString(database: "users")
    ), as: .init(string: "users"))
    
    try app.databases.use(.mongo(
        connectionString: MongoConstatns.connectionString(database: "sample_airbnb")
    ), as: .init(string: "sample_airbnb"))

    // app.migrations.add(CreateUsers())

    // register routes
    try routes(app)
}
