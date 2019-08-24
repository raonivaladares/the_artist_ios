import UIKit

final class ArtDetailsView: UIView {
    
    // MARK: View Actions
    
    enum Event {
        
    }
    
    // MARK: Private properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.yellow
        
        return view
    }()
    
    private let artImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.backgroundColor = .red
        return coverImageView
    }()
    
    private let artTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans-Bold", size: 21)
        
        return label
    }()
    
    private let artPerieodLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans", size: 18)
        
        return label
    }()
    
    private let artDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans", size: 22)
        
        return label
    }()
    
    // MARK: Public properties
    
    typealias OutputHandler = (Event) -> Void
    
    var outputHandler: OutputHandler?
    
    // MARK: Inits
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = UIColor.AppColors.yellow
        
        addViews()
        defineAndActivateConstraints()
    }
}

// MARK: ViewConfigurable

extension ArtDetailsView: ViewConfigurable {
    func configure(with viewModel: ViewModel) {
        artTitleLabel.text = viewModel.artTitleText
        artPerieodLabel.text = viewModel.artPerieodText
        artDescriptionLabel.text = viewModel.artDescriptionText
    }
}

// MARK: Private methods

extension ArtDetailsView {
    func addViews() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(artImageView)
        contentView.addSubviews(artTitleLabel)
        contentView.addSubviews(artPerieodLabel)
        contentView.addSubviews(artDescriptionLabel)
    }
    
    func defineAndActivateConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
        
        contentView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.low)
            $0.edges.equalToSuperview()
        }
        
        artImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        artTitleLabel.snp.makeConstraints {
            $0.top.equalTo(artImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        artPerieodLabel.snp.makeConstraints {
            $0.top.equalTo(artTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        artDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(artPerieodLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.bottom.lessThanOrEqualTo(contentView.snp.bottom)
            $0.trailing.equalToSuperview()
        }
    }
}
