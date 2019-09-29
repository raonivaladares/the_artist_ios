@testable import the_artist_ios

extension ArtModel {
    func asNetworkModel() -> ArtModelNetwork {
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

