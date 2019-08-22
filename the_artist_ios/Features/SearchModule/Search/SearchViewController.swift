import UIKit


protocol ViewConfigurable {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
}

final class SearchViewController: UIViewController {
    private let searchView = SearchView()
    
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

extension SearchViewController: ViewConfigurable {
    typealias ViewModel = SearchView.ViewModel
    
    func configure(with viewModel: ViewModel) {
        searchView.configure(with: viewModel)
    }
}


// MARK: Override methods

extension SearchViewController {
    override func loadView() {
        
        view = searchView
        
        let presenter = self.presenter
        searchView.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}