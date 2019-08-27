import Foundation

final class SearchArtWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func search(query: String, completion: @escaping (Result<ArtSearchResultsModel, ApplicationError>) -> Void) {
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
                let foo = try? decoder.decode(ArtSearchResultsModel.self, from: data)
                completion(.success(foo!))
            case .failure(let error):
                break
            }
        }
    }
}
