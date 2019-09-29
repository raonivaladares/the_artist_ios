final class ArtPaintingFilter {
    func filter(artModels: [ArtModel]) -> [ArtModel] {
        return artModels.filter { $0.objectTypeName == "Painting"}
    }
}
