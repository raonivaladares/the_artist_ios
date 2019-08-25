import Alamofire

final class AlamofireRequestExecuter: RequestExecuter {
    //    let serverErrorParser: WatcherServerErrorParser
    
    init() {
        //        serverErrorParser = WatcherServerErrorParser()
    }
    
    #warning("Change ApplicationError to server error")
    func execute(
        request: Requestable,
        completion: @escaping (Result<Data, ApplicationError>) -> Void) {
        
        Alamofire.AF.request(
            request.path,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: nil).response { dataResponse in
                //                if let error = self.serverErrorParser.parse(dataResponse: dataResponse) {
                //                    completion(.failure(error))
                //                }
                
                guard let data = dataResponse.data else {
                    completion(.failure(.unkown))//ServerError.emptyDataResponse
                    return
                }
                
                completion(.success(data))
        }
    }
}
