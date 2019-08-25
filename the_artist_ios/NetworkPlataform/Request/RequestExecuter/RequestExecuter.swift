import Foundation

protocol RequestExecuter {
    func execute(
        request: Requestable,
        completion: @escaping (Result<Data, ApplicationError>) -> Void)
}
