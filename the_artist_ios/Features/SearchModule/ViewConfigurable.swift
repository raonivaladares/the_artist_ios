import Foundation

protocol ViewConfigurable {
    associatedtype ViewModel
    func configure(with viewModel: ViewModel)
}
