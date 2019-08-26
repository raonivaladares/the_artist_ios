struct ArtSearchResultsModel {
    let totalArtsCount: Int
    let remoteArtsIDs: [Int]
}

extension ArtSearchResultsModel: Decodable {
    private enum CodingKeys : String, CodingKey {
        case totalArtsCount = "total"
        case remoteArtsIDs = "objectIDs"
    }
}
