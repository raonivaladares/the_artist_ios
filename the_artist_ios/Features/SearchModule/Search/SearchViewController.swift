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

// MARK: Override methods - life-cycle

extension SearchViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
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
