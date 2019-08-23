import UIKit

final class SearchResultCell: UITableViewCell {
    // MARK: Private UI properties
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.init(red: 191/255, green: 144/255, blue: 15/255, alpha: 1)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let artNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans-Bold", size: 15)
        
        return label
    }()
    
    private let artPeriodLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViewProperties()
        defineAndActivateConstraints()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: ViewModel) {
        artNameLabel.text = viewModel.artTitle
        artPeriodLabel.text = viewModel.artPeriod
        
//        if let stringPath = content.movieCoverPath,
//            let url = URL(string: stringPath) {
//            coverImageView.load(fromURL: url)
//        }
    }
}

// MARK: - Private methods - UI

extension SearchResultCell {
    private func addViewProperties() {
        contentView.addSubview(coverImageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(artNameLabel)
        stackView.addArrangedSubview(artPeriodLabel)
    }
    
    private func defineAndActivateConstraints() {
        coverImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(contentView.snp.top).offset(20)
            $0.leading.equalTo(contentView.snp.leading).offset(20)
            $0.bottom.greaterThanOrEqualTo(contentView.snp.bottom).offset(-20)
            $0.width.equalTo(90)
            $0.height.equalTo(110)
            $0.centerY.equalTo(contentView.snp.centerY)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(coverImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-20)
            $0.centerY.equalTo(coverImageView.snp.centerY)
        }
    }
}
