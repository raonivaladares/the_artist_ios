import Foundation

final class RetrieveArtWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func retrieveArt(withID artRemoteID: Int) {
        let request = RequestBuilder(
            action: APIAction.RetrieveArt(artRemoteID: artRemoteID),
            configuration: configuration
        )
        .build()
        
        requestExecuter.execute(request: request) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                break
            }
        }
    }
}
