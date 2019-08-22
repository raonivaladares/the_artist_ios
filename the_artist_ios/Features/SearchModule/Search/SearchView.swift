import UIKit

final class SearchView: UIView {
    enum Event {
        case startTyping
        case endTyping(text: String)
    }
    
    // MARK: Private properties
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 140
        tableView.sectionHeaderHeight = 220
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: Public properties - ViewOutputable
    typealias OutputHandler = (Event) -> Void
    
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

extension SearchView: ViewOutput {}

extension SearchView: ViewConfigurable {
    func configure(with viewModel: ViewModel) {
        print("SearchView -> configure")
    }
}

// MARK: Private methods

extension SearchView {
    private func addViews() {
        addSubview(tableView)
    }
    
    private func defineAndActivateConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func registerTableViewElements() {
        //        tableView.register(SearchMovieResultCell.self, forCellReuseIdentifier: "SearchMovieResultCell")
        tableView.register(
            SearchHeaderCell.self,
            forHeaderFooterViewReuseIdentifier: "SearchHeaderCell"
        )
    }
}

// MARK: UITableViewDataSource

extension SearchView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.numberOfRolls
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieResultCell", for: indexPath) as! SearchMovieResultCell
//
//        let content = viewModel.cellContent(forIndex: indexPath.row)
//        cell.configure(withContent: content)
        
//        return cell
        return UITableViewCell()
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
        
//        let item = viewModel.cellContents[indexPath.row]
//        viewActionsHandler?(.itemSelected(item))
    }
    
}

extension SearchView {
    func textFieldDidEndEditing(text: String?) {
        
        if let text = text,
            !text.isEmpty {
            NSObject.cancelPreviousPerformRequests(withTarget: self)
            perform(#selector(search), with: text, afterDelay: 3)
        }
    }
    
    @objc private func search(_ text: String) {
        outputHandler?(.endTyping(text: text))
    }
}

// MARK: UITableViewDelegate

extension SearchView: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        endEditing(true)
    }
}
