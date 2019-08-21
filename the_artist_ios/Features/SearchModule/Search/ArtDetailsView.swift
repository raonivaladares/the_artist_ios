import UIKit

final class ArtDetailsView: UIView {
    // MARK: View Actions
    
    enum Event {
        
    }
    
    // MARK: Private properties
    
    // MARK: Public properties
    typealias OutputHandler = (Event) -> Void
    
    var outputHandler: OutputHandler?
    
    // MARK: Inits
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = UIColor.AppColors.yellow
        
        addViews()
        defineAndActivateConstraints()
    }
}

// MARK: Private methods
extension ArtDetailsView {
    func addViews() {}
    func defineAndActivateConstraints() {}
}
