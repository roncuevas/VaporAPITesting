import Fluent

extension DatabaseID {
    static var users: DatabaseID {
        return .init(string: "users")
    }
    
    static var sampleAirbnb: DatabaseID {
        return .init(string: "sample_airbnb")
    }
}
