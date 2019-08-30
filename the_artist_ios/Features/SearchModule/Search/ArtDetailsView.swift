import UIKit
import Kingfisher

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
        coverImageView.backgroundColor = UIColor(red: 191/255, green: 144/255, blue: 15/255, alpha: 1)
        
        return coverImageView
    }()
    
    private let artTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans-Bold", size: 21)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    private let artCreationDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.black
        label.font = UIFont(name: "OpenSans", size: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    private let artDimensionsLabel: UILabel = {
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
        artCreationDateLabel.text = viewModel.artCreationDateText
        artDimensionsLabel.text = viewModel.artDimenssionsText
        
        if let url = viewModel.coverImageURL {
            artImageView.kf.setImage(with: url)
        }
    }
}

// MARK: Private methods

extension ArtDetailsView {
    func addViews() {
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(artImageView)
        contentView.addSubviews(artTitleLabel)
        contentView.addSubviews(artCreationDateLabel)
        contentView.addSubviews(artDimensionsLabel)
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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        artCreationDateLabel.snp.makeConstraints {
            $0.top.equalTo(artTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        artDimensionsLabel.snp.makeConstraints {
            $0.top.equalTo(artCreationDateLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.lessThanOrEqualTo(contentView.snp.bottom)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
