extension SearchView {
    struct ViewModel {
        let shouldClearTableView: Bool
        let indexToUpdate: Int?
        let cellViewModels: [SearchResultCell.ViewModel]?
        
        init(state: State) {
            switch state {
            case .clearLastSearchResult:
                shouldClearTableView = true
                cellViewModels = nil
                indexToUpdate = nil
            case .tableViewLoading(let cellViewModels):
                shouldClearTableView = false
                self.cellViewModels = cellViewModels
                indexToUpdate = nil
            case .updateListItem(let indexToUpdate, let cellViewModels):
                shouldClearTableView = false
                self.cellViewModels = cellViewModels
                self.indexToUpdate = indexToUpdate
            }
        }
    }
}

extension SearchView.ViewModel {
    enum State {
        case clearLastSearchResult
        case tableViewLoading(cellViewModels: [SearchResultCell.ViewModel])
        case updateListItem(index: Int, cellViewModels: [SearchResultCell.ViewModel])
    }
}
