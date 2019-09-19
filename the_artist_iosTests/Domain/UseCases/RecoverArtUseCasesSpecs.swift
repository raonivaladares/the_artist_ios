import Quick
import Nimble

@testable import the_artist_ios

final class RecoverArtUseCasesSpecs: QuickSpec {
    override func spec() {
        describe("RecoverArtUseCases") {
            var webServiceMock: RetrieveArtWebServiceMock!
            var useCases: RetrieveArtUseCases!
            
            beforeEach {
                webServiceMock = RetrieveArtWebServiceMock()
                useCases = RetrieveArtUseCasesImp(retrieveArtWebService: webServiceMock)
            }
            
            describe("retrieve(artRemoteID: Int)") {
                let stubID = -11
                context("success") {
                    let artModel = ArtModelStubFactory().createAnEmptyArtModel()
                    var resultArtModel: ArtModel?
                    
                    beforeEach {
                        webServiceMock.expectedResult = .success(artModel: artModel.asNetwork())
                        useCases.retrieve(artRemoteID: stubID) { result in
                            if case let .success(artModel) = result {
                                resultArtModel = artModel
                            }
                        }
                    }
                    
                    it("verifies if request succeed with a model as result") {
                        expect(resultArtModel).toEventually(equal(artModel))
                    }
                    
                    it("verifies if webservice was called only once") {
                        expect(webServiceMock.retrieveArtInvocations).to(equal(1))
                    }
                }
                
                context("failure with ApplicationError.unkown") {
                    var resultError: ApplicationError?
                    
                    beforeEach {
                        webServiceMock.expectedResult = .failure(error: ApplicationError.unkown)
                        useCases.retrieve(artRemoteID: stubID) { result in
                            if case let .failure(error) = result {
                                resultError = error
                            }
                        }
                    }
                    
                    it("verifies if request failed with an error ApplicationError.unkown") {
                        expect(resultError).toEventually(equal(ApplicationError.unkown))
                    }
                    
                    it("verifies if webservice was called only once") {
                        expect(webServiceMock.retrieveArtInvocations).to(equal(1))
                    }
                }
            }
        }
    }
}

extension ArtModel {
    func asNetwork() -> ArtModelNetwork {
        return ArtModelNetwork(
            remoteID: remoteID,
            title: title,
            objectTypeName: objectTypeName,
            artCreationDate: artCreationDate,
            artistDisplayName: artistDisplayName,
            dimensions: dimensions,
            culture: culture,
            primaryImage: primaryImage,
            primaryImageSmall: primaryImageSmall
        )
    }
}
