import Foundation

protocol SearchArtUseCases {
    func search(query: String, completion: (Result<ArtSearchResultsModel, ApplicationError>) -> Void)
}

final class SearchArtUseCasesImp {
    private let searchWebService: SearchWebService
    
    init(searchWebService: SearchWebService) {
        self.searchWebService = searchWebService
    }
}

extension SearchArtUseCasesImp: SearchArtUseCases {
    func search(query: String, completion: (Result<ArtSearchResultsModel, ApplicationError>) -> Void) {
        searchWebService.search(query: query) { result in
            
        }
    }
}

enum ApplicationError: Error {
    case unkown
}
