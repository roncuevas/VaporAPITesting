import Foundation

struct MongoConstatns {
    static let user = "roncuevas"
    static let password = "RCCC7665"
    static let server = "cluster0.farfreb.mongodb.net"
    static let database = "users"
    
    static func connectionString(user: String = user,
                                 password: String = password,
                                 server: String = server,
                                 database: String = database) -> String {
        return "mongodb+srv://\(user):\(password)@\(server)/\(database)"
    }
}
