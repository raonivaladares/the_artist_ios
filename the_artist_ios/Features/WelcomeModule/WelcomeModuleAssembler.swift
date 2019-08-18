import UIKit

final class WelcomeModuleAssembler {
    func assemble(navigationController: UINavigationController) -> UIViewController {
        let viewController = WelcomeViewController()
        let router = WelcomeRouter(navigationController: navigationController)
        let presenter = WelcomePresenter(router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}


