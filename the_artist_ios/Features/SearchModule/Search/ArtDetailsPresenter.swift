import Foundation

protocol ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event)
}

final class ArtDetailsPresenter {
    private let viewController: ArtDetailsViewController
    
    init(viewController: ArtDetailsViewController, artModel: ArtModel) {
        self.viewController = viewController
        
        let viewModel = ArtDetailsView.ViewModel(
            artTitleText: artModel.title,
            artCreationDateText: artModel.artCreationDate,
            artDimenssionsText: artModel.dimensions,
            artistDisplayName: artModel.artistDisplayName,
            coverImageURL: URL(string: artModel.primaryImage)
        )
        
        viewController.configure(with: viewModel)
    }
}

extension ArtDetailsPresenter: ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event) {
        
    }
}
