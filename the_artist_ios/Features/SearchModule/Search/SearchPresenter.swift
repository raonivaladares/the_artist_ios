import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    private let viewController: SearchViewController
    private let router: SearchRouter
    
    init(viewController: SearchViewController, router: SearchRouter) {
        self.viewController = viewController
        self.router = router
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            let viewModel = SearchView.ViewModel()
            self.viewController.configure(with: viewModel)
            print("presenter->viewController->configure")
        })
    }
}

extension SearchPresenter: SearchPresentable {
    func viewOutputHandler(event: SearchView.Event) {
        switch event {
        case .startTyping:
            break
        case .endTyping(let text):
            break
        case .cellTapped(let content):
            let artModel = ArtModel(
                remoteID: 1,
                title: "Stub",
                objectName: "Stub",
                period: "Stub",
                culture: "Stub",
                primaryImage: "Stub",
                primaryImageSmall: "Stub"
            )
            router.pushArtDetails(with: artModel)
        }
    }
}

extension SearchView {
    struct ViewModel {
        let searchResultCellsViewModels: [SearchResultCell.ViewModel]
        
        init() {
            searchResultCellsViewModels = [
                SearchResultCell.ViewModel(artTitle: "stub01", artPeriod: "stub01", coverPath: "stub01"),
                SearchResultCell.ViewModel(artTitle: "stub02", artPeriod: "stub02", coverPath: "stub02"),
                SearchResultCell.ViewModel(artTitle: "stub03", artPeriod: "stub03", coverPath: "stub03")
            ]
        }
    }
}
