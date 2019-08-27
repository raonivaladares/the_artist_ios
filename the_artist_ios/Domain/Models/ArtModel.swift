struct ArtModel {
    let remoteID: Int
    let title: String
    let objectTypeName: String
    let period: String
    let culture: String
    
    let primaryImage: String
    let primaryImageSmall: String
}

extension ArtModel: Decodable {
    private enum CodingKeys : String, CodingKey {
        case remoteID = "objectID"
        case title = "title"
        case objectTypeName = "objectName"
        case period = "period"
        case culture = "culture"
        case primaryImage = "primaryImage"
        case primaryImageSmall = "primaryImageSmall"
    }
}
