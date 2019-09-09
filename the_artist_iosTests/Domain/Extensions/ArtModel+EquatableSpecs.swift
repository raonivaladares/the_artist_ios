import Quick
import Nimble

@testable import the_artist_ios

final class ArtModelEquatableSpecs: QuickSpec {
    override func spec() {
        describe("ArtModel+Equatable") {
            context("Equal") {
                let models = ArtModelStubFactory().createEqualsArtModelsForComparation()
                let lhsDictionary = recoverAllProperties(artModel: models.lhs)!
                let rhsDictionary = recoverAllProperties(artModel: models.rhs)!
                
                it("has all properties equals") {
                    expect(models.lhs).to(equal(models.rhs))
                }
                
                it("has all elements of dictionary equals") {
                    let isEqual = NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
                    expect(isEqual).to(beTrue())
                }
            }
            
            context("Different") {
                let models = ArtModelStubFactory().createDifferentsArtModelsForComparation()
                let lhsDictionary = recoverAllProperties(artModel: models.lhs)!
                let rhsDictionary = recoverAllProperties(artModel: models.rhs)!
                
                it("has different properties") {
                    expect(models.lhs).notTo(equal(models.rhs))
                }
                
                it("has differents elements of dictionary") {
                    let isEqual = NSDictionary(dictionary: lhsDictionary).isEqual(to: rhsDictionary)
                    expect(isEqual).notTo(beTrue())
                }
            }
        }
    }
}

// MARK: private methods

extension ArtModelEquatableSpecs {
    private func recoverAllProperties(artModel: ArtModel) -> [String: Any]? {
        var result: [String: Any] = [:]
        
        let mirror = Mirror(reflecting: artModel)
        
        guard let style = mirror.displayStyle, style == .struct || style == .class else {
            return nil
        }
        
        for (labelMaybe, valueMaybe) in mirror.children {
            guard let label = labelMaybe else {
                continue
            }
            
            result[label] = valueMaybe
        }
        
        return result
    }
}
