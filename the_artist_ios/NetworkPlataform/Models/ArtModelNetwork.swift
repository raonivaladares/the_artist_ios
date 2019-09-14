import Foundation

struct ArtModelNetwork {
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

extension ArtModelNetwork: Codable {
    private enum CodingKeys : String, CodingKey {
        case remoteID = "objectID"
        case title = "title"
        case objectTypeName = "objectName"
        case dimensions = "dimensions"
        case artCreationDate = "objectDate"
        case artistDisplayName = "artistDisplayName"
        case culture = "culture"
        case primaryImage = "primaryImage"
        case primaryImageSmall = "primaryImageSmall"
    }
}
