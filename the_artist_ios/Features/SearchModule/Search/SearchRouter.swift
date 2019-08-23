import UIKit

final class SearchRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushArtDetails(with artModel: ArtModel) {
        let viewController = ArtDetailsAssembler()
            .assemble(navigationController: navigationController)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
