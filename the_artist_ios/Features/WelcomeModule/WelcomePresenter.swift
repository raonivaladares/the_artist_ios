import UIKit

protocol WelcomePresentable {
    func viewOutputHandler(event: WelcomeView.Event)
}

final class WelcomePresenter {
    private let router: WelcomeRouter
    
    // MARK: Inits
    
    init(router: WelcomeRouter) {
        
        self.router = router
    }
}

// MARK: WelcomePresentable

extension WelcomePresenter: WelcomePresentable {
    func viewOutputHandler(event: WelcomeView.Event) {
        router.presentSearch()
    }
}
