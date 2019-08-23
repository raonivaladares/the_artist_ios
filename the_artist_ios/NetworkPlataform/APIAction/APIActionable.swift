import Alamofire

protocol APIActionable {
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

struct APIAction {
    struct SearchContent: APIActionable {
        var path: String = "/search"
        var method: HTTPMethod = .get
        var encoding: ParameterEncoding = URLEncoding(destination: .queryString)
    }
}
