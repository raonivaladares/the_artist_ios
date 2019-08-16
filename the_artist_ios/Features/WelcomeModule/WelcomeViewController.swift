import UIKit

final class WelcomeViewController: UIViewController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        
    }
    
    var presenter: WelcomePresentable?
    
    override func loadView() {
        let view = WelcomeView()
//        view.viewActionsHandler()
    }
}
