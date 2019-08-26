import Alamofire

protocol APIActionable {
    var path: String { get }
    var method: HTTPMethod { get }
    var encoding: ParameterEncoding { get }
}

struct APIAction {
    struct SearchArt: APIActionable {
        var path: String = "/search"
        var method: HTTPMethod = .get
        var encoding: ParameterEncoding = URLEncoding(destination: .queryString)
    }
    
    struct RetrieveArt: APIActionable {
        private let artRemoteID: Int
        
        init(artRemoteID: Int) {
            self.artRemoteID = artRemoteID
        }
        
        var path: String { return "/objects/\(artRemoteID)" }
        var method: HTTPMethod = .get
        var encoding: ParameterEncoding = URLEncoding.default
    }
}
