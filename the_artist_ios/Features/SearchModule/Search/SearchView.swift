import UIKit

final class SearchView: UIView {
    enum Event {
        
    }
    
    // MARK: Public properties - ViewOutputable
    typealias OutputHandler = (Event) -> Void
    
    var outputHandler: OutputHandler?
}

extension SearchView: ViewOutput {}

protocol ViewOutput {
    associatedtype Event
    typealias OutputHandler =  ((Event) -> Void)
    
    var outputHandler: OutputHandler? { get set }
}
