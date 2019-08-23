import Foundation

struct SearchWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func search(query: String) {
        let parameters = ["q": query]
        let request = RequestBuilder(
            action: APIAction.SearchContent(),
            configuration: configuration
        )
        .parameters(parameters: parameters)
        .build()
        
        requestExecuter.execute(request: request)
        print(request)
    }
}
