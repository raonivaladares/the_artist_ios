import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    private let viewController: SearchViewController
    
    init(viewController: SearchViewController, router: SearchRouter) {
        self.viewController = viewController
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            let viewModel = SearchView.ViewModel()
            self.viewController.configure(with: viewModel)
            print("presenter->viewController->configure")
        })
    }
}

extension SearchPresenter: SearchPresentable {
    func viewOutputHandler(event: SearchView.Event) {
        
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
