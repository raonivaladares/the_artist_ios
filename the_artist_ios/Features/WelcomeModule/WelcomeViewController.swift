import UIKit

final class WelcomeViewController: UIViewController {
    var presenter: WelcomePresentable?
}

// MARK: Inits

extension WelcomeViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
}

// MARK: Override life-cycle

extension WelcomeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: Override life-cycle

extension WelcomeViewController {
    override func loadView() {
        let view = WelcomeView()
        self.view = view
        
        let presenter = self.presenter
        view.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}
