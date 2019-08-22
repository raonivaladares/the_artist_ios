import UIKit

final class ArtDetailsAssembler {
    func assemble(navigationController: UINavigationController) -> UIViewController {
        let viewController = ArtDetailsViewController()
        let presenter = ArtDetailsPresenter()
        
        viewController.presenter = presenter
        
        return viewController
    }
}
