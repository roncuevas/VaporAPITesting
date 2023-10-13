import Fluent
import Vapor
import BSON

final class ListingsAndReviewsModel: Model, Content {
    static let schema = "listingsAndReviews"
    
    @ID(custom: .id, generatedBy: .database)
    var id: String?

    @Field(key: "name")
    var name: String
    
    @Field(key: "summary")
    var summary: String

    init() { }

    init(id: String? = nil, name: String, summary: String) {
        self.id = id
        self.name = name
        self.summary = summary
    }
}
