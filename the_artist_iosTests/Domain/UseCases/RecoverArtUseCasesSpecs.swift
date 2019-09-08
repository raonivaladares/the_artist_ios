import Quick
import Nimble

@testable import the_artist_ios

final class RecoverArtUseCasesSpecs: QuickSpec {
    override func spec() {
        describe("RecoverArtUseCases") {
            describe("retrieve(artRemoteID: Int)") {
                let stubID = -11
                context("success") {
                    //Given
                    let webServiceMock = RetrieveArtWebServiceMock()
                    let artModel = ArtModelStubFactory().createArtModel()
                    webServiceMock.expectedResult = .success(artModel: artModel)
                    let useCases = RetrieveArtUseCasesImp(retrieveArtWebService: webServiceMock)
                    
                    var resultArtModel: ArtModel?
                    
                    //When
                    useCases.retrieve(artRemoteID: stubID) { result in
                        if case let .success(artModel) = result {
                            resultArtModel = artModel
                        }
                    }

                    //Them
                    it("verifies if request succeed with a model as result") {
                        expect(resultArtModel).toEventually(equal(artModel))
                    }
                    
                    it("verifies if webservice was called only once") {
                        expect(webServiceMock.retrieveArtInvocations).to(equal(1))
                    }
                }
                
                context("failure with ApplicationError.unkown") {
                    //Given
                    let webServiceMock = RetrieveArtWebServiceMock()
                    webServiceMock.expectedResult = .failure(error: ApplicationError.unkown)
                    let useCases = RetrieveArtUseCasesImp(retrieveArtWebService: webServiceMock)
                    var resultError: ApplicationError?
                    
                    //When
                    useCases.retrieve(artRemoteID: stubID) { result in
                        if case let .failure(error) = result {
                            resultError = error
                        }
                    }
                    
                    //Them
                    it("verifies if request failed with an error ApplicationError.unkown") {
                        expect(resultError).toEventually(equal(ApplicationError.unkown))
                    }
                }
            }
        }
    }
}

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

extension ArtModel: Equatable {
    public static func ==(lhs: ArtModel, rhs: ArtModel) -> Bool {
        return
            lhs.remoteID == rhs.remoteID &&
            lhs.title == rhs.title &&
            lhs.objectTypeName == rhs.objectTypeName &&
            lhs.artCreationDate == rhs.artCreationDate &&
            lhs.artistDisplayName == rhs.artistDisplayName &&
            lhs.dimensions == rhs.dimensions &&
            lhs.culture == rhs.culture &&
            lhs.primaryImage == rhs.primaryImage &&
            lhs.primaryImageSmall == rhs.primaryImageSmall
    }
}

final class ArtModelStubFactory {
    func createArtModel() -> ArtModel {
        return ArtModel(
            remoteID: -1,
            title: "",
            objectTypeName: "",
            artCreationDate: "",
            artistDisplayName: "",
            dimensions: "",
            culture: "",
            primaryImage: "",
            primaryImageSmall: ""
        )
    }
}
