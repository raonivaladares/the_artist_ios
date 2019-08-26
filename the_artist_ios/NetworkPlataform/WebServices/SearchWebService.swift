import Foundation

struct SearchWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func search(query: String, completion: (Result<ArtSearchResultsModel, ApplicationError>) -> Void) {
        let parameters = ["q": query]
        let request = RequestBuilder(
            action: APIAction.SearchContent(),
            configuration: configuration
        )
        .parameters(parameters: parameters)
        .build()
        
        requestExecuter.execute(request: request) { result in
            switch result {
            case .success(let deta):
                break
            case .failure(let error):
                break
            }
        }
    }
}
