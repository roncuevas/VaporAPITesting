import Vapor

struct FileRedirectMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        let fileName: String = request.parameters.get("fileName") ?? ""
        return request.redirect(to: "https://bucket.roncuevas.com/\(fileName)", redirectType: .normal)
    }
}
