import UIKit

final class ArtDetailsAssembler {
    func assemble(
        artModel: ArtModel,
        navigationController: UINavigationController) -> UIViewController {
        
        let viewController = ArtDetailsViewController()
        let presenter = ArtDetailsPresenter(viewController: viewController, artModel: artModel)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
