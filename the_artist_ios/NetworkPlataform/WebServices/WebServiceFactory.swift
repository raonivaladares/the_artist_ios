import Foundation

final class WebServiceFactory {
    func createSearchArtWebService() -> SearchArtWebService {
        let configuration = TheMETWebServiceConfiguration()
        let requestExecuter = AlamofireRequestExecuter()
        let webService = SearchArtWebService(configuration: configuration, requestExecuter: requestExecuter)
        
        return webService
    }
    
    func createRetrieveArtWebService() -> RetrieveArtWebService {
        let configuration = TheMETWebServiceConfiguration()
        let requestExecuter = AlamofireRequestExecuter()
        let webService = RetrieveArtWebServiceImp(configuration: configuration, requestExecuter: requestExecuter)
        
        return webService
    }
}
