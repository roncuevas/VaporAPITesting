import Foundation
import Vapor

struct UserAuthenticator: AsyncBearerAuthenticator {
    typealias User = App.UserAuthenticatable

    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
       if bearer.token == "foo" {
           request.auth.login(User(name: "Vapor"))
       }
   }
}
