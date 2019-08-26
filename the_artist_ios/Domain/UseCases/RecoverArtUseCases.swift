import Foundation

protocol RetrieveArtUseCases {
    func retrieve(artID: Int, completion: (Result<ArtModel, ApplicationError>) -> Void)
}

final class RetrieveArtUseCasesImp {
    private let retrieveArtWebService: RetrieveArtWebService
    
    init(retrieveArtWebService: RetrieveArtWebService) {
        self.retrieveArtWebService = retrieveArtWebService
    }
}

extension RetrieveArtUseCasesImp: RetrieveArtUseCases {
    func retrieve(artID: Int, completion: (Result<ArtModel, ApplicationError>) -> Void) {
        retrieveArtWebService.retrieveArt(withID: 1)
    }
}
