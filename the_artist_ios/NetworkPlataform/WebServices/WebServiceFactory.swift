import Foundation

final class WebServiceFactory {
    func createSearchWebService() -> SearchWebService {
        let configuration = TheMETWebServiceConfiguration()
        let requestExecuter = AlamofireRequestExecuter()
        let webService = SearchWebService(configuration: configuration, requestExecuter: requestExecuter)
        
        return webService
    }
    
    func createArtDetailsWebService() -> ArtDetailsWebService {
        let configuration = TheMETWebServiceConfiguration()
        let requestExecuter = AlamofireRequestExecuter()
        let webService = ArtDetailsWebService(configuration: configuration, requestExecuter: requestExecuter)
        
        return webService
    }
}
