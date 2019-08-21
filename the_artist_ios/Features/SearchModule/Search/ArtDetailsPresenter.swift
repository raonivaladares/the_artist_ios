import Foundation

protocol ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event)
}

final class ArtDetailsPresenter {
    
}

extension ArtDetailsPresenter: ArtDetailsPresentable {
    func viewOutputHandler(event: ArtDetailsView.Event) {
        
    }
}
