extension SearchView {
    struct ViewModel {
        let isEmptySearchHidden: Bool
        let cellsViewModels: [SearchResultCell.ViewModel]
        
        init(state: State) {
            switch state {
            case .showContent(let cellsViewModels):
                self.cellsViewModels = cellsViewModels
                isEmptySearchHidden = true
            case .noResultsState:
                cellsViewModels = []
                isEmptySearchHidden = false
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
