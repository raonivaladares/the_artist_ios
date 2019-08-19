import UIKit

final class SearchViewController: UIViewController {
    var presenter: SearchPresentable?
}

// MARK: Inits

extension SearchViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
}


// MARK: Override methods

extension SearchViewController {
    override func loadView() {
        let view = SearchView()
        self.view = view
        
        let presenter = self.presenter
        view.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}
