import Foundation

protocol RetrieveArtUseCases {
    func retrieve(artRemoteIDs ids: [Int], completion: @escaping (Result<[ArtModel], ApplicationError>) -> Void)
}

final class RetrieveArtUseCasesImp {
    private let retrieveArtWebService: RetrieveArtWebService
    
    init(retrieveArtWebService: RetrieveArtWebService) {
        self.retrieveArtWebService = retrieveArtWebService
    }
}

extension RetrieveArtUseCasesImp: RetrieveArtUseCases {
    func retrieve(artRemoteIDs ids: [Int], completion: @escaping (Result<[ArtModel], ApplicationError>) -> Void) {
        var artModels: [ArtModel] = []
                
        for (index, id) in ids.enumerated() {
            let isLastID = index == ids.count - 1
            
            retrieveArtWebService.retrieveArt(withID: id) { result in
                if let artModel = self.handleRetriveResult(result: result),
                    artModel.objectTypeName == "Painting" {
                    artModels.append(artModel)
                }
                
                if isLastID {
                    completion(.success(artModels))
                }
            }
        }
    }
    
    private func handleRetriveResult(result: Result<ArtModelNetwork, ApplicationError>) -> ArtModel? {
        switch result {
        case .success(let artModelNetwork):
            let artModel = artModelNetwork.asDomain()
            return artModel
        case .failure(let error):
            return nil
        }
    }
}
