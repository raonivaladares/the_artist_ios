import Foundation

final class RetrieveArtWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func retrieveArt(withID artRemoteID: Int, completion: @escaping (Result<ArtModel, ApplicationError>) -> Void) {
        let request = RequestBuilder(
            action: APIAction.RetrieveArt(artRemoteID: artRemoteID),
            configuration: configuration
        )
        .build()
        
        requestExecuter.execute(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let artModel = try! decoder.decode(ArtModel.self, from: data)
                completion(.success(artModel))
            case .failure(let error):
                break
            }
        }
    }
}
