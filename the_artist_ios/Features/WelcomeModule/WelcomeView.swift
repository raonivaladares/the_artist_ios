import UIKit
import SnapKit

class WelcomeView: UIView {
    let appLogoImageView: UIImageView = {
        let image = UIImage(named: "app_logo")
        let imageview = UIImageView(image: image)
        
        return imageview
    }()
    
    let welcomeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text =
        "The $79 iWork ’08 appears to be a good deal for anyone needing an affordable office suite for the Mac."
        
        label.textAlignment = .center
        label.font = UIFont.init(name: "OpenSans-Semibold", size: 18)
        label.textColor = UIColor.AppColors.black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.init(name: "OpenSans-Extrabold", size: 15)
        button.backgroundColor = UIColor.AppColors.black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(actionButtonHandler(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let tmdLogoImageView = UIImageView()
    
    let theMETThanksLabel: UILabel = {
        let label = UILabel()
        label.text = "Thanks The MET for the content"
        label.textAlignment = .left
        label.font = UIFont.init(name: "OpenSans-Semibold", size: 14)
        label.textColor = UIColor.AppColors.black.withAlphaComponent(0.4)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let centerContainerView = UIView()
    
    let bottomContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        return stackView
    }()
    
    convenience init() {
        self.init(frame: .zero)
        
        backgroundColor = .purple
        addViews()
        defineAndActivateConstraints()
    }
}

// MARK: Action Handlers
extension WelcomeView {
    @objc private func actionButtonHandler(_ sender: UIButton) {
//        viewActionsHandler?(.confirmed)
    }
}

// MARK: - Private methods

extension WelcomeView {
    private func addViews() {
        centerContainerView.addSubviews(
            appLogoImageView,
            welcomeDescriptionLabel,
            actionButton
        )
        
        bottomContainerStackView.addArrangedSubview(tmdLogoImageView)
        bottomContainerStackView.addArrangedSubview(theMETThanksLabel)
        
        addSubviews(
            centerContainerView,
            bottomContainerStackView
        )
    }
    
    private func defineAndActivateConstraints() {
        centerContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalToSuperview().multipliedBy(0.65)
        }
        
        appLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        welcomeDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(appLogoImageView.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        actionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(welcomeDescriptionLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        bottomContainerStackView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(60)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-60)
        }
        
        tmdLogoImageView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(44)
        }
    }
}

extension UIColor {
    struct AppColors {
        private init() { }
        
        static var black: UIColor {
            return UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1)
        }
        
        static var yellow: UIColor {
            return  UIColor(red: 254/255, green: 211/255, blue: 0/255, alpha: 1)
        }
        
        static var white: UIColor {
            return  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview)
    }
}
