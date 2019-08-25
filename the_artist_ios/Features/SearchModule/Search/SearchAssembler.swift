import UIKit

final class SearchAssembler {
    func assemble(navigationController: UINavigationController) -> UIViewController {
        let searchWebService = WebServiceFactory().createSearchWebService()
        let searchArtUseCases = SearchArtUseCasesImp(searchWebService: searchWebService)
        
        let viewController = SearchViewController()
        let router = SearchRouter(navigationController: navigationController)
        let presenter = SearchPresenter(
            searchArtUseCases: searchArtUseCases,
            viewController: viewController,
            router: router
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
