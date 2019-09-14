struct ArtModel {
    let remoteID: Int
    let title: String
    let objectTypeName: String
    let artCreationDate: String
    let artistDisplayName: String
    let dimensions: String
    let culture: String
    let primaryImage: String
    let primaryImageSmall: String
}

extension ArtModelNetwork {
    func asDomain() -> ArtModel {
        return ArtModel(
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
