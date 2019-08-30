import Foundation

extension SearchResultCell {
    struct ViewModel {
        let isLoading: Bool
        let artTitle: String
        let artCompletionYear: String
        let artImageURL: URL?
//        let positionAtTableView: Int
        
        //TODO: Refactor init to have more context when it is loading
        init() {
            self.isLoading = true
            artTitle = "Loading"
            artCompletionYear = "Loading"
            artImageURL = nil
        }
        
        init (artTitle: String, artCompletionYear: String, artImageURL: URL?) {
            isLoading = false
            self.artTitle = artTitle
            self.artCompletionYear = artCompletionYear
            self.artImageURL = artImageURL
        }
    }
}
