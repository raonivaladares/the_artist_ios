import Foundation

final class RequestBuilder {
    let action: APIActionable
    let configuration: WebServiceConfiguration
    var parameters: [String : Any]?
    
    init(action: APIActionable, configuration: WebServiceConfiguration) {
        self.action = action
        self.configuration = configuration
    }
    
    func parameters(parameters: [String : Any]) -> RequestBuilder {
        self.parameters = parameters
        
        return self
    }
    
    func build() -> Requestable {
        let path = configuration.apiBaseURL.appendingPathComponent(action.path)
        return Request(
            path: path,
            method: action.method,
            encoding: action.encoding,
            parameters: parameters
        )
    }
}
