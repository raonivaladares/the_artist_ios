import Foundation

protocol RetrieveArtUseCases {
    func retrieve(artRemoteIDs ids: [Int], completion: @escaping ([ArtModel]) -> Void)
}

final class RetrieveArtUseCasesImp {
    private let artPaintingFilter: ArtPaintingFilter
    private let retrieveArtWebService: RetrieveArtWebService
    
    init(artPaintingFilter: ArtPaintingFilter,
         retrieveArtWebService: RetrieveArtWebService) {
        
        self.artPaintingFilter = artPaintingFilter
        self.retrieveArtWebService = retrieveArtWebService
    }
}

// MARK: RetrieveArtUseCases

extension RetrieveArtUseCasesImp: RetrieveArtUseCases {
    func retrieve(artRemoteIDs ids: [Int], completion: @escaping ([ArtModel]) -> Void) {
        var artModels: [ArtModel] = []
        
        let retrieveDispatchGroup = DispatchGroup()
        
        for id in ids {
            retrieveDispatchGroup.enter()
            
            retrieveArtWebService.retrieveArt(withID: id) { [weak self] result in
                guard let `self` = self else { return }
                
                if let artModel = self.handleRetriveResult(result: result) {
                    artModels.append(artModel)
                }
                
                retrieveDispatchGroup.leave()
            }
        }
        
        retrieveDispatchGroup.notify(queue: DispatchQueue.main) {
            let filteredArtModels = self.artPaintingFilter.filter(artModels: artModels)
            completion(filteredArtModels)
        }
    }
    
    private func handleRetriveResult(result: Result<ArtModelNetwork, ApplicationError>) -> ArtModel? {
        let artModelResult: ArtModel?
        
        switch result {
        case .success(let artModelNetwork):
            let artModel = artModelNetwork.asDomain()
            artModelResult = artModel
        case .failure(let error):
            print(error)
            artModelResult = nil
        }
        
        return artModelResult
    }
}
