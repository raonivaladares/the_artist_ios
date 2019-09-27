import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    private let searchArtUseCases: SearchArtUseCases
    private let retrieveArtUseCases: RetrieveArtUseCases
    private let viewController: SearchViewController
    private let router: SearchRouter
    private var asyncTaskSome: DispatchWorkItem?
    
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
    }
}

extension SearchPresenter: SearchPresentable {
    func viewOutputHandler(event: SearchView.Event) {
        switch event {
        case .startTyping:
            clearCurrentSearchResults()
        case .endTyping(let text):
            asyncTaskSome?.cancel()
            let asyncTaskSome = DispatchWorkItem { self.searchForArt(withText: text) }
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: asyncTaskSome)
            self.asyncTaskSome = asyncTaskSome
        case .cellTapped(let cellViewModel):
            cellTapped(with: cellViewModel)
        }
    }
    
    private func clearCurrentSearchResults() {
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func searchResultHandler(_ artSearchResultModel: ArtSearchResultsModel) {
        let fetchBanchLimite = 20
        let artIDsToRetrieve = artSearchResultModel.remoteArtsIDs
        
        banchOfIDsToRetrieve = artIDsToRetrieve.chunked(into: fetchBanchLimite)
        
        if let ids = banchOfIDsToRetrieve.first {
            updateViewWithLoadingCell()
            banchOfIDsToRetrieve.removeFirst()
            retriveArtsFromIDs(ids)
        }
    }
    
    private func updateViewWithLoadingCell() {
        let cellViewModels = [SearchResultCell.ViewModel()]

        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: cellViewModels))
        self.viewController.configure(with: viewModel)
    }
    
    private func retriveArtsFromIDs(_ ids: [Int]) {
        retrieveArtUseCases.retrieve(artRemoteIDs: ids) { [weak self] artModels in
            guard let `self` = self else { return }
            
            self.artModels.append(contentsOf: artModels)
            print("BEGIN -----------------------------------------------------------------")
            for artModel in artModels {
                let cellViewModel = self.createCellViewModel(with: artModel)
                self.cellViewModels.append(cellViewModel)
            }
            
            print("-----------------------------------------------------------------")
            print(self.cellViewModels)
            print("-----------------------------------------------------------------")
            print("END -----------------------------------------------------------------")
//            DispatchQueue.main.async {
                let viewModel = SearchView.ViewModel(
                    state: .showContent(cellsViewModels: self.cellViewModels)
                )
                self.viewController.configure(with: viewModel)
//            }
        }
    }
    
    private func createCellViewModel(with artModel: ArtModel) -> SearchResultCell.ViewModel {
        return SearchResultCell.ViewModel(
            artTitle: artModel.title,
            artCompletionYear: artModel.artCreationDate,
            artImageURL: URL(string: artModel.primaryImageSmall)
        )
    }
    
    private func cellTapped(with cellViewModel: SearchResultCell.ViewModel) {
        let artModel = artModels.filter { $0.title == cellViewModel.artTitle }
            .first!
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
