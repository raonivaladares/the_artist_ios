import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    init(viewController: SearchViewController, router: SearchRouter) {
        
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
