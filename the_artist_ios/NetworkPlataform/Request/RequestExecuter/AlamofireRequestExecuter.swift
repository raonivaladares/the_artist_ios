import Alamofire

final class AlamofireRequestExecuter: RequestExecuter {
    //    let serverErrorParser: WatcherServerErrorParser
    
    init() {
        //        serverErrorParser = WatcherServerErrorParser()
    }
    
    func execute(request: Requestable) { //completion: @escaping (Result<JSON, ServerError>) -> Void
        Alamofire.AF.request(
            request.path,
            method: request.method,
            parameters: request.parameters,
            encoding: request.encoding,
            headers: nil).response { dataResponse in
                //                if let error = self.serverErrorParser.parse(dataResponse: dataResponse) {
                //                    completion(.failure(error))
                //                }
                
                //                guard let data = dataResponse.data else {
                //                    completion(.failure(ServerError.emptyDataResponse))
                //                    return
                //                }
                
                //                let json = JSON(data)
                //                completion(.success(json))
                print(dataResponse)
        }
    }
}
