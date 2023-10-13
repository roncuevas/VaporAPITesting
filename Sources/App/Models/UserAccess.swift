import Fluent
import Vapor
import BSON

final class UserAccess: Model, Content {
    static let schema = "access"
    
    @ID(custom: .id, generatedBy: .database)
    var id: ObjectId?

    @Field(key: "user")
    var user: String
    
    @Field(key: "password")
    var password: String

    init() { }

    init(id: ObjectId? = nil, user: String, password: String) {
        self.id = id
        self.user = user
        self.password = password
    }
}
