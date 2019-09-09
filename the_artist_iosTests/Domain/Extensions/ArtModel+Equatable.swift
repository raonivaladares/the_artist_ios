@testable import the_artist_ios

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
