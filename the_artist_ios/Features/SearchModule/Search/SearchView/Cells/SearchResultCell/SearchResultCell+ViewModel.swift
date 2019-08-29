extension SearchResultCell {
    struct ViewModel {
        let isLoading: Bool
        let artTitle: String
        let artPeriod: String
        let coverPath: String
//        let positionAtTableView: Int
        
        //TODO: Refactor init to have more context when it is loading
        init() {
            self.isLoading = true
            artTitle = "Stub artTitle loading"
            artPeriod = "Stub  artPeriod loading"
            coverPath = "Stub  coverPath loading"
        }
        
        init (artTitle: String, artPeriod: String, coverPath: String) {
            isLoading = false
            self.artTitle = artTitle
            self.artPeriod = artPeriod
            self.coverPath = coverPath
        }
    }
}
