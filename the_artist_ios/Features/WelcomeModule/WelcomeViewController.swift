import UIKit

final class WelcomeViewController: UIViewController {
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .purple
    }
    
    var presenter: WelcomePresentable?
}
