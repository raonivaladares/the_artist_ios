import Quick
import Nimble

@testable import the_artist_ios

final class RecoverArtUseCasesSpecs: QuickSpec {
    override func spec() {
        describe("RecoverArtUseCases") {
            var webServiceMock: RetrieveArtWebServiceMock!
            var useCases: RetrieveArtUseCases!
            let artPaintingFilter = ArtPaintingFilter()
            
            beforeEach {
                webServiceMock = RetrieveArtWebServiceMock()
                useCases = RetrieveArtUseCasesImp(
                    artPaintingFilter: artPaintingFilter,
                    retrieveArtWebService: webServiceMock)
            }
            
            describe("retrieve(artRemoteID: Int)") {
                let stubID = -11
                context("success") {
                    let artModel = ArtModelStubFactory().createAnStubPaintingArtModel()
                    var resultArtModel: ArtModel?
                    
                    beforeEach {
                        let artModelNetwork = artModel.asNetworkModel()
                        webServiceMock.expectedResult = .success(artModel: artModelNetwork)
                        useCases.retrieve(artRemoteIDs: [stubID]) { artModels in
                            resultArtModel = artModels.first!
                        }
                    }
                    
                    it("verifies if request succeed with a model as result") {
                        expect(resultArtModel).toEventually(equal(artModel))
                    }
                    
                    it("verifies if webservice was called only once") {
                        expect(webServiceMock.retrieveArtInvocations).to(equal(1))
                    }
                }
            }
        }
    }
}
