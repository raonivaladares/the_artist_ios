import UIKit

final class SearchRouter {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

// MARK: Public methods

extension SearchRouter {
    func pushArtDetails(with artModel: ArtModel) {
        let viewController = ArtDetailsAssembler()
            .assemble(artModel: artModel, navigationController: navigationController)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
