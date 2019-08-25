import Foundation

protocol SearchArtUseCases {
    func search(query: String, completion: (Result<ArtSearchResult, ApplicationError>) -> Void)
}

final class SearchArtUseCasesImp {
    private let searchWebService: SearchWebService
    
    init(searchWebService: SearchWebService) {
        self.searchWebService = searchWebService
    }
}

extension SearchArtUseCasesImp: SearchArtUseCases {
    func search(query: String, completion: (Result<ArtSearchResult, ApplicationError>) -> Void) {
        searchWebService.search(query: query) { result in
            
        }
    }
}

struct ArtSearchResult {
    let remoteArtsIDs: [Int]
}

enum ApplicationError: Error {
    case unkown
}
