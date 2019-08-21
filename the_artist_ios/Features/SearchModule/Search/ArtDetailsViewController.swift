import UIKit

final class ArtDetailsViewController: UIViewController {
    // MARK: Public properties
    var presenter: ArtDetailsPresenter?
}

// MARK: Override methods

extension ArtDetailsViewController {
    override func loadView() {
        let view = ArtDetailsView()
        self.view = view
        
        let presenter = self.presenter
        view.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}

