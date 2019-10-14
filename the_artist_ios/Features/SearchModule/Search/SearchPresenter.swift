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
        case .presentedLastElements:
            self.presentedLastElementsHandler()
        }
    }
    
    private func presentedLastElementsHandler() {
        if let lastViewModelCell = cellViewModels.last,
               lastViewModelCell.isLoading != true {
            
            addLoadingView()
            let ids = retrieveNextIDsForFetch()
            retriveArtsFromIDsFromLastElementsEvent(ids)
        }
    }
    
    private func retriveArtsFromIDsFromLastElementsEvent(_ ids: [Int]) {
        retrieveArtUseCases.retrieve(
            artRemoteIDs: ids,
            completion: { [weak self] in self?.retriveArtsFromIDsFooHandler(artModels: $0) }
        )
    }
    
    private func retriveArtsFromIDsFooHandler(artModels: [ArtModel]) {
        self.artModels.append(contentsOf: artModels)
        
        removeLoadingFromCellViewModels()
        createAndAppendCellViewModels(artModels: artModels)
        updateContentFromViewController(cellViewModels: cellViewModels)
    }
    
    private func updateContentFromViewController(cellViewModels: [SearchResultCell.ViewModel]) {
        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: cellViewModels))
        self.viewController.configure(with: viewModel)
    }
    
    private func removeLoadingFromCellViewModels() {
        cellViewModels = cellViewModels.dropLast()
    }
    
    private func createAndAppendCellViewModels(artModels: [ArtModel]) {
        let newCellViewModels = artModels.map(createCellViewModel(with:))
        cellViewModels.append(contentsOf: newCellViewModels)
    }
    
    private func retrieveNextIDsForFetch() -> [Int] {
        let idsSlice = banchOfIDsToRetrieve.dropFirst().first
        return idsSlice ?? []
    }
    
    private func addLoadingView() {
        let loadingCellViewModel = SearchResultCell.ViewModel()
        cellViewModels.append(loadingCellViewModel)
        
        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: cellViewModels))
        self.viewController.configure(with: viewModel)
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
        
        if artIDsToRetrieve.isEmpty {
            let viewModel = SearchView.ViewModel(state: .noResultsState)
            viewController.configure(with: viewModel)
        } else {
            banchOfIDsToRetrieve = artIDsToRetrieve.chunked(into: fetchBanchLimite)
            
            if let ids = banchOfIDsToRetrieve.first {
                updateViewWithLoadingCell()
                banchOfIDsToRetrieve.removeFirst()
                retriveArtsFromIDsFromSearch(ids)
            }
        }
    }
    
    private func updateViewWithLoadingCell() {
        let cellViewModels = [SearchResultCell.ViewModel()]

        let viewModel = SearchView.ViewModel(state: .showContent(cellsViewModels: cellViewModels))
        self.viewController.configure(with: viewModel)
    }
    
    private func retriveArtsFromIDsFromSearch(_ ids: [Int]) {
        retrieveArtUseCases.retrieve(artRemoteIDs: ids) { [weak self] artModels in
            guard let `self` = self else { return }
            
            if self.artModels.isEmpty && artModels.isEmpty {
                let viewModel = SearchView.ViewModel(state: .noResultsState)
                self.viewController.configure(with: viewModel)
            } else {
                let cellViewModels = artModels.map(self.createCellViewModel(with:))
                self.cellViewModels.append(contentsOf: cellViewModels)
                
                self.artModels.append(contentsOf: artModels)
                
                let viewModel = SearchView.ViewModel(
                    state: .showContent(cellsViewModels: self.cellViewModels)
                )
                self.viewController.configure(with: viewModel)
            }
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
