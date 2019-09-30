import UIKit
import SnapKit

final class WelcomeView: UIView {
    // MARK: View Actions
    
    enum Event {
        case actionButtonTapped
    }
    
    // MARK: Private properties
    
    private let appLogoImageView: UIImageView = {
        let image = UIImage(named: "app_logo")
        let imageview = UIImageView(image: image)
        
        return imageview
    }()
    
    private let welcomeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text =
        "The $79 iWork ’08 appears to be a good deal for anyone needing an affordable office suite for the Mac."
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Semibold", size: 18)
        label.textColor = UIColor.AppColors.black.withAlphaComponent(0.8)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "OpenSans-Extrabold", size: 15)
        button.backgroundColor = UIColor.AppColors.black
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(actionButtonHandler(_:)), for: .touchUpInside)
        
        return button
    }()
    
    private let theMETLogoImageView: UIImageView = {
        let image = UIImage(named: "the_met_logo")
        let imageview = UIImageView(image: image)
        
        return imageview
    }()
    
    private let theMETThanksLabel: UILabel = {
        let label = UILabel()
        label.text = "Thanks The MET for the content"
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-Semibold", size: 14)
        label.textColor = UIColor.AppColors.black.withAlphaComponent(0.4)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private let centerContainerView = UIView()
    
    private let bottomContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        
        return stackView
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

// MARK: - Action Handlers

extension WelcomeView {
    @objc private func actionButtonHandler(_ sender: UIButton) {
        outputHandler?(.actionButtonTapped)
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
        
        bottomContainerStackView.addArrangedSubview(theMETLogoImageView)
        bottomContainerStackView.addArrangedSubview(theMETThanksLabel)
        
        addSubviews(
            centerContainerView,
            bottomContainerStackView
        )
    }
    
    private func defineAndActivateConstraints() {
        centerContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-10)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(30)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-30)
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
        
        theMETLogoImageView.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(44)
        }
    }
}
