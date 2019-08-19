import Foundation

protocol SearchPresentable {
    func viewOutputHandler(event: SearchView.Event)
}

final class SearchPresenter {
    init(router: SearchRouter) {
        
    }
}

extension SearchPresenter: SearchPresentable {
    func viewOutputHandler(event: SearchView.Event) {
        
    }
}
