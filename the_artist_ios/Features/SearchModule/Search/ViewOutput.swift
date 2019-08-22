protocol ViewOutput {
    associatedtype Event
    typealias OutputHandler =  ((Event) -> Void)
    
    var outputHandler: OutputHandler? { get set }
}
