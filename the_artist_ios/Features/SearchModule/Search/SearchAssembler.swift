import UIKit

final class SearchAssembler {
    func assemble(navigationController: UINavigationController) -> UIViewController {
        let searchArtWebService = WebServiceFactory().createSearchArtWebService()
        let searchArtUseCases = SearchArtUseCasesImp(searchWebService: searchArtWebService)
        
        let artPaintingFilter = ArtPaintingFilter()
        let retrieveArtWebService = WebServiceFactory().createRetrieveArtWebService()
        let retrieveArtUseCases = RetrieveArtUseCasesImp(
            artPaintingFilter: artPaintingFilter,
            retrieveArtWebService: retrieveArtWebService
        )
        
        let viewController = SearchViewController()
        let router = SearchRouter(navigationController: navigationController)
        let presenter = SearchPresenter(
            searchArtUseCases: searchArtUseCases,
            retrieveArtUseCases: retrieveArtUseCases,
            viewController: viewController,
            router: router
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
