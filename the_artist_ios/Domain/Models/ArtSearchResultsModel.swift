struct ArtSearchResultsModel {
    let totalArtsCount: Int
    let remoteArtsIDs: [Int]
}

extension ArtSearchResultsModelNetwork {
    func asDomain() -> ArtSearchResultsModel {
        return ArtSearchResultsModel(
            totalArtsCount: self.totalArtsCount,
            remoteArtsIDs: self.remoteArtsIDs ?? []
        )
    }
}
