import Foundation

final class SearchArtWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func search(query: String, completion: @escaping (Result<ArtSearchResultsModelNetwork, ApplicationError>) -> Void) {
        let parameters = ["q": query]
        let request = RequestBuilder(
            action: APIAction.SearchArt(),
            configuration: configuration
        )
        .parameters(parameters: parameters)
        .build()
        
        requestExecuter.execute(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let artSearchResultsModelNetwork = try? decoder.decode(ArtSearchResultsModelNetwork.self, from: data)
                if let artSearchResultsModelNetwork = artSearchResultsModelNetwork {
                    completion(.success(artSearchResultsModelNetwork))
                } else {
                    completion(.failure(.unkown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
