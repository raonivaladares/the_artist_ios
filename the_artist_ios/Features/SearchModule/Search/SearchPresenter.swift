import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    private let searchArtUseCases: SearchArtUseCases
    private let retrieveArtUseCases: RetrieveArtUseCases
    private let viewController: SearchViewController
    private let router: SearchRouter
    
//    private var positionsMap: [Int: Int] = [:]
    private var artIDsToRetrieve: [Int] = []
    
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
        let viewModel = SearchView.ViewModel(state: .clearLastSearchResult)
        viewController.configure(with: viewModel)
    }
    
    private func searchForArt(withText text: String) {
        searchArtUseCases.search(query: text) { result in
            switch result {
            case .success(let artSearchResultModel):
                let cellViewModels = [SearchResultCell.ViewModel()]
                let viewModel = SearchView.ViewModel(state: .tableViewLoading(cellViewModels: cellViewModels))
                self.viewController.configure(with: viewModel)
                self.searchResultHandler(artSearchResultModel)
            case .failure(let error): break
            }
        }
    }
    
    
    private func searchResultHandler(_ artSearchResultModel: ArtSearchResultsModel) {
        artIDsToRetrieve = artSearchResultModel.remoteArtsIDs
        retriveArtsFromIDs(artIDsToRetrieve)
//        retrieveArtUseCases.retrieve(artRemoteID: 1) { result in
//            switch result {
//            case .success(let artModel):
//                self.artModels.append(artModel)
////                let count = self.positionsMap.count + 1
////                self.positionsMap[artModel.remoteID] = count
//                let cellViewModel = SearchResultCell.ViewModel(artTitle: artModel.title, artPeriod: artModel.period, coverPath: "")
//                let viewModel = SearchView.ViewModel(state: .updateListItem(items: [(0, cellViewModel)]))
//                self.viewController.configure(with: viewModel)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    private func retriveArtsFromIDs(_ ids: [Int]) {
        var count = 0
        for id in ids {
            if count  >= 20 { break }
            count += 1
            retriveArtsFromID(id)
        }
    }
    
    private func retriveArtsFromID(_ id: Int) {
        retrieveArtUseCases.retrieve(artRemoteID: id) { [weak self] result in
            switch result {
            case .success(let artModel):
                self?.incrementArtModels(artModel: artModel)
                print("____________________________________________________________________________________")
                print(self?.artModels.count ?? -1000)
                print("____________________________________________________________________________________")
            case .failure(let error):
                break
            }
        }
    }
    
    private func incrementArtModels(artModel: ArtModel) {
        artModels.append(artModel)
    }
    
    private func cellTapped(with cellViewModel: SearchResultCell.ViewModel) {
        let artModel = ArtModel(
            remoteID: 1,
            title: "Stub",
            objectTypeName: "Stub",
            period: "Stub",
            culture: "Stub",
            primaryImage: "Stub",
            primaryImageSmall: "Stub"
        )
        router.pushArtDetails(with: artModel)
    }
}

extension SearchView {
    struct ViewModel {
        let shouldClearTableView: Bool
        let cellViewModels: [SearchResultCell.ViewModel]?
        let updatableItems: [(position: Int, cellViewModel: SearchResultCell.ViewModel)]?
        
        init(state: State) {
            switch state {
            case .clearLastSearchResult:
                shouldClearTableView = true
                cellViewModels = nil
                updatableItems = nil
            case .tableViewLoading(let cellViewModels):
                shouldClearTableView = false
                self.cellViewModels = cellViewModels
                updatableItems = nil
            case .updateListItem(let updatableItems):
                shouldClearTableView = false
                cellViewModels = nil
                self.updatableItems = updatableItems
            }
        }
    }
}

extension SearchView.ViewModel {
    enum State {
        case clearLastSearchResult
        case tableViewLoading(cellViewModels: [SearchResultCell.ViewModel])
        case updateListItem(items: [(position: Int, cellViewModel: SearchResultCell.ViewModel)])
    }
}
