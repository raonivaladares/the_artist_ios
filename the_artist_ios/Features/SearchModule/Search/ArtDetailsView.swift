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
    
    private let coverImageView: UIImageView = {
        let coverImageView = UIImageView()
        coverImageView.backgroundColor = .red
        return coverImageView
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

// MARK: Private methods
extension ArtDetailsView {
    func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(coverImageView)
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
        
        coverImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
}
