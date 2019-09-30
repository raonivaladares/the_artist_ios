import UIKit

final class SearchView: UIView {
    enum Event {
        case startTyping
        case endTyping(text: String)
        case cellTapped(content: SearchResultCell.ViewModel)
    }
    
    // MARK: Private properties - UI
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 140
        tableView.sectionHeaderHeight = 220
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let emptySearchLabel: UILabel = {
        let label = UILabel()
        label.text = "There is no result for this search"
        label.isHidden = true
        
        return label
    }()
    
    // MARK: Private properties
    
    private var cellsViewModels: [SearchResultCell.ViewModel] = []
    
    // MARK: Public properties - ViewOutput
    
    var outputHandler: OutputHandler?
    
    // MARK: Inits
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = UIColor.AppColors.yellow
        
        addViews()
        defineAndActivateConstraints()
        registerTableViewElements()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - ViewOutput

extension SearchView: ViewOutput {
    typealias OutputHandler = (Event) -> Void
}

// MARK: - ViewConfigurable

extension SearchView: ViewConfigurable {
    func configure(with viewModel: ViewModel) {
        cellsViewModels = viewModel.cellsViewModels
        tableView.reloadData()
        
        emptySearchLabel.isHidden = viewModel.isEmptySearchHidden
    }
}

// MARK: - Action handlers

extension SearchView {
    @objc private func search(_ text: String) {
        outputHandler?(.endTyping(text: text))
    }
}

// MARK: - Private methods

extension SearchView {
    private func textFieldDidEndEditing(text: String?) {
        outputHandler?(.startTyping) //TODO: remove temp clean up
        
        if let text = text,
            !text.isEmpty {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            perform(#selector(search), with: text, afterDelay: 3)
        }
    }
}

// MARK: - Private methods - UI

extension SearchView {
    private func addViews() {
        addSubviews(
            tableView,
            emptySearchLabel
        )
    }
    
    private func defineAndActivateConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
        
        emptySearchLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func registerTableViewElements() {
        tableView.register(
            SearchHeaderCell.self,
            forHeaderFooterViewReuseIdentifier: SearchHeaderCell.reuseIdentifier
        )
        tableView.register(
            SearchResultCell.self,
            forCellReuseIdentifier: SearchResultCell.reuseIdentifier
        )
    }
}

// MARK: - UITableViewDataSource

extension SearchView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)
            as! SearchResultCell

        let viewModel = cellsViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchHeaderCell") as! SearchHeaderCell
        header.textFieldEditingDidChangeHandler = { [weak self] text in
            self?.textFieldDidEndEditing(text: text)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        endEditing(true)
        
        let cellViewModel = cellsViewModels[indexPath.row]
        outputHandler?(.cellTapped(content: cellViewModel))
    }
}

// MARK: - UITableViewDelegate

extension SearchView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
}
