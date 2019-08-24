import UIKit

final class ArtDetailsViewController: UIViewController {
    private let artDetailsView = ArtDetailsView()
    
    // MARK: Public properties
    
    var presenter: ArtDetailsPresenter?
}

// MARK: Override methods

extension ArtDetailsViewController {
    override func loadView() {
        self.view = artDetailsView
        
//        let presenter = self.presenter
//        view.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}

// MARK: ViewConfigurable

extension ArtDetailsViewController: ViewConfigurable {
    typealias ViewModel = ArtDetailsView.ViewModel
    
    func configure(with viewModel: ViewModel) {
        artDetailsView.configure(with: viewModel)
    }
}
