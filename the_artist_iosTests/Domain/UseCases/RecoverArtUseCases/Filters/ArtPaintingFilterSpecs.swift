import Quick
import Nimble

@testable import the_artist_ios

final class ArtPaintingFilterSpecs: QuickSpec {
    override func spec() {
        describe("filter") {
            let artPaintingFilter = ArtPaintingFilter()
            
            context("empty array") {
                let filteredModels = artPaintingFilter.filter(artModels: [])
                
                it("returns an empty array") {
                    expect(filteredModels).to(beEmpty())
                }
            }
            
            context("array with 1 artModel of type: other") {
                let artModel = ArtModelStubFactory().createAnStubOtherArtModel()
                
                let filteredModels = artPaintingFilter.filter(artModels: [artModel])
                
                it("returns an empty array") {
                    expect(filteredModels).to(beEmpty())
                }
            }
            
            context("array with 1 artModel of type: Painting") {
                let artModel = ArtModelStubFactory().createAnStubPaintingArtModel()
                
                let filteredModels = artPaintingFilter.filter(artModels: [artModel])
                
                it("returns an array with 1 artModel") {
                    expect(filteredModels.count).to(equal(1))
                }
            }
            
            context("array with 1 artModel of type: other, and with 1 of type: Painting") {
                let otherArtModel = ArtModelStubFactory().createAnStubOtherArtModel()
                let paintingArtModel = ArtModelStubFactory().createAnStubPaintingArtModel()
                
                let filteredModels = artPaintingFilter
                    .filter(artModels: [otherArtModel, paintingArtModel])
                
                it("returns an array with 1 artModel") {
                    expect(filteredModels.count).to(equal(1))
                }
            }
            
            context("array with 10 artModel of type: other, and with 10 of type: Painting") {
                var artModels: [ArtModel] = []
                let range = 0 ..< 10
                
                range.forEach { _ in
                    let otherArtModel = ArtModelStubFactory().createAnStubOtherArtModel()
                    artModels.append(otherArtModel)
                    
                    let paintingArtModel = ArtModelStubFactory().createAnStubPaintingArtModel()
                    artModels.append(paintingArtModel)
                }
                
                let filteredModels = artPaintingFilter.filter(artModels: artModels)
                
                it("returns an array with 1 artModel") {
                    expect(filteredModels.count).to(equal(10))
                }
            }
        }
    }
}

