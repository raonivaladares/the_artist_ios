import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    private let fetchBanchLimite = 20
    
    private let searchArtUseCases: SearchArtUseCases
    private let retrieveArtUseCases: RetrieveArtUseCases
    private let viewController: SearchViewController
    private let router: SearchRouter
    
//    private var positionsMap: [Int: Int] = [:]
    private var artIDsToRetrieve: [Int] = []
    private var banchOfIDsToRetrieve: [[Int]] = []
    
    private var artModels: [ArtModel] = []
    private var cellViewModels: [SearchResultCell.ViewModel] = []
    
    init(searchArtUseCases: SearchArtUseCases,
         retrieveArtUseCases: RetrieveArtUseCases,
         viewController: SearchViewController,
         router: SearchRouter) {
        
        self.searchArtUseCases = searchArtUseCases
        self.retrieveArtUseCases = retrieveArtUseCases
        self.viewController = viewController
        self.router = router
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
//            let viewModel = SearchView.ViewModel()
//            self.viewController.configure(with: viewModel)
//        })
    }
}

extension SearchPresenter: SearchPresentable {
    func viewOutputHandler(event: SearchView.Event) {
        switch event {
        case .startTyping:
            clearCurrentSearchResults()
        case .endTyping(let text):
            searchForArt(withText: text)
        case .cellTapped(let cellViewModel):
            cellTapped(with: cellViewModel)
        }
    }
    
    private func clearCurrentSearchResults() {
        artIDsToRetrieve = []
        artModels = []
        cellViewModels = []
        banchOfIDsToRetrieve = []
        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: []))
        viewController.configure(with: viewModel)
    }
    
    private func searchForArt(withText text: String) {
        searchArtUseCases.search(query: text) { result in
            switch result {
            case .success(let artSearchResultModel):
                self.searchResultHandler(artSearchResultModel)
            case .failure(let error): break
            }
        }
    }
    
    
    
    private func searchResultHandler(_ artSearchResultModel: ArtSearchResultsModel) {
        artIDsToRetrieve = artSearchResultModel.remoteArtsIDs ?? []
        banchOfIDsToRetrieve = artIDsToRetrieve.chunked(into: fetchBanchLimite)
        
        if let ids = banchOfIDsToRetrieve.first {
            updateViewWithLoadingCell()
            banchOfIDsToRetrieve.removeFirst()
            retriveArtsFromIDs(ids)
        }
    }
    
    private func updateViewWithLoadingCell() {
        var cellViewModels: [SearchResultCell.ViewModel] = [SearchResultCell.ViewModel()]

        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: cellViewModels))
        self.viewController.configure(with: viewModel)
    }
    
    private func retriveArtsFromIDs(_ ids: [Int]) {
        retrieveArtUseCases.retrieve(artRemoteIDs: ids) { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let artModels):
                self.artModels.append(contentsOf: artModels)
                
                for artModel in artModels {
                    let cellViewModel = SearchResultCell.ViewModel(
                        artTitle: artModel.title,
                        artCompletionYear: artModel.artCreationDate,
                        artImageURL: URL(string: artModel.primaryImageSmall)
                    )
                    self.cellViewModels.append(cellViewModel)
                }
                
                DispatchQueue.main.async {
                    let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: self.cellViewModels))
                    self.viewController.configure(with: viewModel)
                }
                print("____________________________________________________________________________________")
                print(self.artModels.count)
                print("____________________________________________________________________________________")
            case .failure(let error):
                break
            }
        }
    }
    
    private func retriveArtsFromID(_ id: Int) {
        
    }
    
    private func cellTapped(with cellViewModel: SearchResultCell.ViewModel) {
        let artModel = artModels.filter { $0.title == cellViewModel.artTitle }.first!
        router.pushArtDetails(with: artModel)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
