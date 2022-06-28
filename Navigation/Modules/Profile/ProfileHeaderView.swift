//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 19.10.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    private enum Constants {
        static let avatarImageName: String = "belka"
        static let avatarImageBorderWidth: CGFloat = 3.0
        static let avatarImageViewBorderColor: CGColor = UIColor.white.cgColor
        
        static let topIndentAvatarView: CGFloat = 16.0
        static let rightIndentAvatarView: CGFloat = 16.0
        
        static let rightIndentLabelView: CGFloat = 27.0
        
        static let LabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let LabelColor: UIColor = .black
        
        static let StatusFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let StatusColor: UIColor = .gray
        
        static let showStatusButtonCornerRadius: CGFloat = 12.0
        static let showStatusShadowOffset: CGSize = CGSize(width: 4, height: 4)
        static let showStatusShadowRadius: CGFloat = 4.0
        static let showStatusShadowColor: CGColor = UIColor.black.cgColor
        static let showStatusShadowOpacity: Float = 0.7
        static let showStatusButtonHeight: CGFloat = 50.0
        static let topIndentshowStatusButton: CGFloat = 54.0 // увеличил, так как не влазил TextField
        
        static let textFieldFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let textFieldCornerRadius: CGFloat = 12
        static let textFieldColor: UIColor = .black
        static let textFieldBackgroundColor: UIColor = .white
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldBorderColor: CGColor = UIColor.black.cgColor
        static let textFieldHeight: CGFloat = 40.0
    }
    
    lazy var avatarImageView: UIImageView = {
        avatarImageView = UIImageView(image: UIImage(named: Constants.avatarImageName))

        return avatarImageView
    }()
    
    lazy var fullNameLabel: UILabel = {
        fullNameLabel = UILabel()
        fullNameLabel.font = Constants.LabelFont
        fullNameLabel.textColor = Constants.LabelColor
        
        return fullNameLabel
    }()
    
    lazy var statusView: UILabel = {
        statusView = UILabel()
        statusView.font = Constants.StatusFont
        statusView.text = "Waiting for something..."
        statusView.textColor = Constants.StatusColor
        
        return statusView
    }()
    
    lazy var showStatusButton: CustomButton = {
        showStatusButton = CustomButton(title: "Set status", titleColor: .white, onTap: {[weak self] in
                                                                                            self?.buttonPressed()})
//        showStatusButton.setTitleColor(.white, for: .normal)
//        showStatusButton.setTitle("Set status", for: .normal)
        showStatusButton.backgroundColor = .blue
        
        showStatusButton.layer.cornerRadius = Constants.showStatusButtonCornerRadius
        showStatusButton.layer.shadowColor = Constants.showStatusShadowColor
        showStatusButton.layer.shadowOffset = Constants.showStatusShadowOffset
        showStatusButton.layer.shadowOpacity = Constants.showStatusShadowOpacity
        showStatusButton.layer.shadowRadius = Constants.showStatusShadowRadius
        
//        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return showStatusButton
    }()
    
    lazy var textField: UITextField = {
        textField = UITextField()
        textField.backgroundColor = Constants.textFieldBackgroundColor
        textField.font = Constants.textFieldFont
        textField.textColor = Constants.textFieldColor
        textField.placeholder = "Set Status..."
        
        textField.layer.cornerRadius = Constants.textFieldCornerRadius
        textField.layer.borderColor = Constants.textFieldBorderColor
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return textField
    }()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray5
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupNick()
        setupStatus()
        setupShowStatusButton()
        setupTextField()
        setupImage()
        
        setupLayout()
    }
    
    private func setupLayout() {
        let navBarHeight = CGFloat(self.safeAreaInsets.top)
        avatarImageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(Constants.rightIndentAvatarView)
            maker.top.equalToSuperview().inset(Constants.topIndentAvatarView + navBarHeight)
            maker.height.equalTo(self.frame.width/3)
            maker.width.equalTo(self.frame.width/3)
        }
        
        fullNameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(Constants.rightIndentLabelView + navBarHeight)
            maker.leading.equalTo(avatarImageView.snp.trailing).offset(20)
        }
        
        statusView.snp.makeConstraints { maker in
            maker.leading.equalTo(fullNameLabel)
            maker.top.equalTo(fullNameLabel.snp.bottom).offset(40)
        }
        
        showStatusButton.snp.makeConstraints { maker in
            maker.trailing.equalToSuperview().inset(Constants.rightIndentLabelView)
            maker.leading.equalToSuperview().inset(Constants.rightIndentLabelView)
            maker.height.equalTo(Constants.showStatusButtonHeight)
            maker.top.equalTo(statusView.snp.bottom).offset(Constants.topIndentshowStatusButton)
        }
        
        textField.snp.makeConstraints { maker in
            maker.leading.equalTo(statusView).inset(-10)
            maker.trailing.equalTo(showStatusButton)
            maker.bottom.equalTo(showStatusButton.snp.top).offset(-5)
            maker.height.equalTo(Constants.textFieldHeight)
        }
    }
    
    private func setupImage() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.borderWidth = Constants.avatarImageBorderWidth
        avatarImageView.layer.borderColor = Constants.avatarImageViewBorderColor
        self.addSubview(avatarImageView)
    }
    
    private func setupNick() {
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        //fullNameLabel.text = "Hipster Cat"
        self.addSubview(fullNameLabel)
    }
    
    private func setupStatus() {
        statusView.toAutoLayout()
        self.addSubview(statusView)
    }
    
    private func setupShowStatusButton(){
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showStatusButton)
    }
    
    private func setupTextField(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.layer.borderColor = Constants.textFieldBorderColor
        textField.layer.borderWidth = Constants.textFieldBorderWidth
        textField.leftViewMode = .always
        self.addSubview(textField)
    }
    
    func initWithUser(user: User){
        fullNameLabel.text = user.fullName
        statusView.text = user.status
        avatarImageView.image = UIImage(named: user.avatar)
    }
    
    func buttonPressed() {
        guard !statusText.isEmpty else {
            UIView.animate(withDuration: 0.5) {
                [weak self] in
                self?.textField.layer.borderWidth = 2
                self?.textField.layer.borderColor = UIColor.red.cgColor
                self?.layoutIfNeeded()
            }
            return
        }
        
        statusView.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? " "
    }
}


