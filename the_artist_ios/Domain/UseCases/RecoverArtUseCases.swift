import Foundation

protocol RetrieveArtUseCases {
    func retrieve(artRemoteID id: Int, completion: @escaping (Result<ArtModel, ApplicationError>) -> Void)
}

final class RetrieveArtUseCasesImp {
    private let retrieveArtWebService: RetrieveArtWebService
    
    init(retrieveArtWebService: RetrieveArtWebService) {
        self.retrieveArtWebService = retrieveArtWebService
    }
}

extension RetrieveArtUseCasesImp: RetrieveArtUseCases {
    func retrieve(artRemoteID id: Int, completion: @escaping (Result<ArtModel, ApplicationError>) -> Void) {
        retrieveArtWebService.retrieveArt(withID: id) { result in
            switch result {
            case .success(let artModel):
                completion(.success(artModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
