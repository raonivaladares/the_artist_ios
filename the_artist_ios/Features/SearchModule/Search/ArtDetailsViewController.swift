import UIKit

final class ArtDetailsViewController: UIViewController {
    private let artDetailsView = ArtDetailsView()
    
    // MARK: Public properties
    
    var presenter: ArtDetailsPresenter?
}

// MARK: Override methods - life-cycle

extension ArtDetailsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
}

// MARK: Override methods

extension ArtDetailsViewController {
    override func loadView() {
        self.view = artDetailsView
    }
}

// MARK: ViewConfigurable

extension ArtDetailsViewController: ViewConfigurable {
    typealias ViewModel = ArtDetailsView.ViewModel
    
    func configure(with viewModel: ViewModel) {
        artDetailsView.configure(with: viewModel)
    }
}
