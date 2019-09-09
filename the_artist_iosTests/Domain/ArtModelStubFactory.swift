@testable import the_artist_ios

final class ArtModelStubFactory {
    func createAnEmptyArtModel() -> ArtModel {
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
    
    func createEqualsArtModelsForComparation() -> (lhs: ArtModel, rhs: ArtModel) {
        let lhs = ArtModel(
            remoteID: 1,
            title: "title",
            objectTypeName: "objectTypeName",
            artCreationDate: "artCreationDate",
            artistDisplayName: "artistDisplayName",
            dimensions: "dimensions",
            culture: "culture",
            primaryImage: "primaryImage",
            primaryImageSmall: "primaryImageSmall"
        )
        
        let rhs = ArtModel(
            remoteID: 1,
            title: "title",
            objectTypeName: "objectTypeName",
            artCreationDate: "artCreationDate",
            artistDisplayName: "artistDisplayName",
            dimensions: "dimensions",
            culture: "culture",
            primaryImage: "primaryImage",
            primaryImageSmall: "primaryImageSmall"
        )
        
        return (lhs, rhs)
    }
    
    func createDifferentsArtModelsForComparation() -> (lhs: ArtModel, rhs: ArtModel) {
        let lhs = ArtModel(
            remoteID: 1,
            title: "titleLHS",
            objectTypeName: "objectTypeNameLHS",
            artCreationDate: "artCreationDateLHS",
            artistDisplayName: "artistDisplayNameLHS",
            dimensions: "dimensionsLHS",
            culture: "cultureLHS",
            primaryImage: "primaryImageLHS",
            primaryImageSmall: "primaryImageSmallLHS"
        )
        
        let rhs = ArtModel(
            remoteID: 2,
            title: "titleRHS",
            objectTypeName: "objectTypeNameRHS",
            artCreationDate: "artCreationDateRHS",
            artistDisplayName: "artistDisplayNameRHS",
            dimensions: "dimensionsRHS",
            culture: "cultureRHS",
            primaryImage: "primaryImageRHS",
            primaryImageSmall: "primaryImageSmallRHS"
        )
        
        return (lhs, rhs)
    }
}
