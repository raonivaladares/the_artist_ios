import UIKit

final class SearchAssembler {
    func assemble(navigationController: UINavigationController) -> UIViewController {
        let viewController = SearchViewController()
        let router = SearchRouter(navigationController: navigationController)
        let presenter = SearchPresenter(viewController: viewController, router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
