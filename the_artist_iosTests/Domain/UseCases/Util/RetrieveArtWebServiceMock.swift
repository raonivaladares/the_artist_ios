@testable import the_artist_ios

final class RetrieveArtWebServiceMock: RetrieveArtWebService {
    enum ExpectedResult {
        case success(artModel: ArtModelNetwork)
        case failure(error: ApplicationError)
    }
    
    var expectedResult: ExpectedResult?
    var retrieveArtInvocations = 0
    
    func retrieveArt(
        withID artRemoteID: Int,
        completion: @escaping (Result<ArtModelNetwork, ApplicationError>) -> Void) {
        
        retrieveArtInvocations += 1
        
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .success(let artModelNetwork):
            completion(.success(artModelNetwork))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
