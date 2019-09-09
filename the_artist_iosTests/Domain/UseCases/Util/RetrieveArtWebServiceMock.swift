@testable import the_artist_ios

final class RetrieveArtWebServiceMock: RetrieveArtWebService {
    enum ExpectedResult {
        case success(artModel: ArtModel)
        case failure(error: ApplicationError)
    }
    
    var expectedResult: ExpectedResult?
    var retrieveArtInvocations = 0
    
    func retrieveArt(
        withID artRemoteID: Int,
        completion: @escaping (Result<ArtModel, ApplicationError>) -> Void) {
        
        retrieveArtInvocations += 1
        
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .success(let artModel):
            completion(.success(artModel))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
