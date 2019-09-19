extension SearchView {
    struct ViewModel {
        let isNoResultsLabelVisible: Bool
        let cellsViewModels: [SearchResultCell.ViewModel]
        
        init(state: State) {
            switch state {
            case .showContent(let cellsViewModels):
                self.cellsViewModels = cellsViewModels
                isNoResultsLabelVisible = false
            case .noResultsState:
                cellsViewModels = []
                isNoResultsLabelVisible = true
            }
        }
    }
}

extension SearchView.ViewModel {
    enum State {
        case noResultsState
        case showContent(cellsViewModels: [SearchResultCell.ViewModel])
    }
}
