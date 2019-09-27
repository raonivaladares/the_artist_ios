import Foundation

protocol RetrieveArtWebService {
    func retrieveArt(
        withID artRemoteID: Int,
        completion: @escaping (Result<ArtModelNetwork, ApplicationError>) -> Void)
}

final class RetrieveArtWebServiceImp: RetrieveArtWebService {
    private let configuration: WebServiceConfiguration
    private let requestExecuter: RequestExecuter
    
    init(configuration: WebServiceConfiguration, requestExecuter: RequestExecuter) {
        self.configuration = configuration
        self.requestExecuter = requestExecuter
    }
    
    func retrieveArt(
        withID artRemoteID: Int,
        completion: @escaping (Result<ArtModelNetwork, ApplicationError>) -> Void) {
        
        let request = RequestBuilder(
            action: APIAction.RetrieveArt(artRemoteID: artRemoteID),
            configuration: configuration
        )
        .build()
        
        requestExecuter.execute(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                //TODO: exceptions?
                if let artModelNetwork = try? decoder.decode(ArtModelNetwork.self, from: data) {
                    completion(.success(artModelNetwork))
                } else {
                    completion(.failure((.unkown)))
                }
            case .failure(let error):
                completion(.failure(.unkown))
            }
        }
    }
}
