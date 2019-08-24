import Foundation

protocol ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event)
}

final class ArtDetailsPresenter {
    private let viewController: ArtDetailsViewController
    
    init(viewController: ArtDetailsViewController, artModel: ArtModel) {
        self.viewController = viewController
        
        let viewModel = ArtDetailsView.ViewModel(
            artTitleText: "Stub Title",
            artPerieodText: "Stub Period",
            artDescriptionText: "Stub Description"
        )
        
        viewController.configure(with: viewModel)
    }
}

extension ArtDetailsPresenter: ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event) {
        
    }
}
