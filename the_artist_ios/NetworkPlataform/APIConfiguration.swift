import Foundation

protocol WebServiceConfiguration {
    var apiBaseURL: URL { get }
}

struct TheMETWebServiceConfiguration: WebServiceConfiguration {
    let apiBaseURL = URL(
        string: "https://collectionapi.metmuseum.org/public/collection/v1"
    )!
}
