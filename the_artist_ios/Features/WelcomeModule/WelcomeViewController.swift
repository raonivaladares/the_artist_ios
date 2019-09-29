import UIKit

final class WelcomeViewController: UIViewController {
    // MARK: Public properties
    
    var presenter: WelcomePresentable?
}

// MARK: Inits

extension WelcomeViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
}

// MARK: Override methods - life-cycle

extension WelcomeViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

// MARK: Override methods

extension WelcomeViewController {
    override func loadView() {
        let view = WelcomeView()
        self.view = view
        
        let presenter = self.presenter
        view.outputHandler = { presenter?.viewOutputHandler(event: $0) }
    }
}
