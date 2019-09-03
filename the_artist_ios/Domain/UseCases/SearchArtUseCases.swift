import Foundation

protocol SearchArtUseCases {
    func search(query: String, completion: @escaping (Result<ArtSearchResultsModel, ApplicationError>) -> Void)
}

final class SearchArtUseCasesImp {
    private let searchWebService: SearchArtWebService
    
    init(searchWebService: SearchArtWebService) {
        self.searchWebService = searchWebService
    }
}

extension SearchArtUseCasesImp: SearchArtUseCases {
    func search(query: String, completion: @escaping (Result<ArtSearchResultsModel, ApplicationError>) -> Void) {
        searchWebService.search(query: query) { result in
            switch result {
            case .success(let artSearchResultsModel):
                completion(.success(artSearchResultsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
