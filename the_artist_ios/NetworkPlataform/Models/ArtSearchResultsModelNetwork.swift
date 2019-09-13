struct ArtSearchResultsModelNetwork {
    let totalArtsCount: Int
    let remoteArtsIDs: [Int]?
}

extension ArtSearchResultsModelNetwork: Decodable {
    private enum CodingKeys : String, CodingKey {
        case totalArtsCount = "total"
        case remoteArtsIDs = "objectIDs"
    }
}
