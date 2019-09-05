import Quick
import Nimble

@testable import the_artist_ios

final class RecoverArtUseCasesSpecs: QuickSpec {
    override func spec() {
        describe("RecoverArtUseCases") {
            describe("retrieve(artRemoteID") {
                context("retrieve at should succeed") {
                    //Given
                    let robot = RetrieveArtUseCasesRobot()
                    let artModel = ArtModelStubFactory().createArtModel()
                    
                    //When
                    robot.configureResult(expectedResult: .success(artModel: artModel))
                    robot.retriveArt()
                    it("???") {
                        //Them
                        robot.isTestSucceed()
                    }
                }
                
                context("retrieve at should fail with X error") {
                    //Given
                    let robot = RetrieveArtUseCasesRobot()
                    let error = ApplicationError.unkown
                    
                    //When
                    robot.configureResult(expectedResult: .failure(error: error))
                    robot.retriveArt()
                    it("?????") {
                        //Them
//                        expect(robot.isTestSucceed()).to(beTrue())
                    }
                }
            }
        }
    }
}

final class RetrieveArtUseCasesRobot {
    enum ExpectedResult {
        case success(artModel: ArtModel)
        case failure(error: ApplicationError)
    }
    
    private var useCases: RetrieveArtUseCases
    private var expectedResult: ExpectedResult?
    
    //
    private var artModel: ArtModel?
    private var error: Error?
    
    private let requestExecuter: TestRequestExecuter
    
    init() {
        let configuration = TestAPIConfiguration()
        
        requestExecuter = TestRequestExecuter()
        
        let webService = RetrieveArtWebService(configuration: configuration, requestExecuter: requestExecuter)
        useCases = RetrieveArtUseCasesImp(retrieveArtWebService: webService)
    }
    
    func configureResult(expectedResult: ExpectedResult) {
        switch expectedResult {
        case .success(let artModel):
            let jsonEncoder = JSONEncoder()
            let data = try! jsonEncoder.encode(artModel)
            requestExecuter.expectedResult = .success(artModel: data)
        case .failure(let error):
            requestExecuter.expectedResult = .failure(error: error)
        }
        
        self.expectedResult = expectedResult
    }
    
    func retriveArt() {
        let notImportantID = -11
        useCases.retrieve(artRemoteID: notImportantID) { result in
            switch result {
            case .success(let artModel):
                self.artModel = artModel
            case .failure(let error):
                self.error = error
            }
        }
    }
    
    func isTestSucceed() -> Bool {
        return false
    }
    
    private func compareWithExpectedResult() -> Bool {
        guard let expectedResult = expectedResult else { return false }
        
        return false
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

struct TestAPIConfiguration: WebServiceConfiguration {
    var apiBaseURL: URL = URL(string: "stub_api_url")!
}

final class TestRequestExecuter: RequestExecuter {
    enum ExpectedResult {
        case success(artModel: Data)
        case failure(error: ApplicationError)
    }
    
    var expectedResult: ExpectedResult?
    
    func execute(request: Requestable, completion: @escaping (Result<Data, ApplicationError>) -> Void) {
        guard let expectedResult = expectedResult else { return }
        
        switch expectedResult {
        case .success(let data):
            completion(.success(data))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}
