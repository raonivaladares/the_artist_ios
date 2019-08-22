import UIKit

final class WelcomeRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func presentSearch() {
        
        let navigationControllerToPresent = UINavigationController()
        let viewController = SearchAssembler()
            .assemble(navigationController: navigationControllerToPresent)
        
        navigationControllerToPresent.viewControllers = [viewController]
        
        navigationController.present(navigationControllerToPresent, animated: true)
    }
}
