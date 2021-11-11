//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 19.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    private enum Constants {
        static let avatarImageName: String = "hipster cat"
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
    
    lazy var showStatusButton: UIButton = {
        showStatusButton = UIButton()
        showStatusButton.setTitleColor(.white, for: .normal)
        showStatusButton.setTitle("Set status", for: .normal)
        showStatusButton.backgroundColor = .blue
        
        showStatusButton.layer.cornerRadius = Constants.showStatusButtonCornerRadius
        showStatusButton.layer.shadowColor = Constants.showStatusShadowColor
        showStatusButton.layer.shadowOffset = Constants.showStatusShadowOffset
        showStatusButton.layer.shadowOpacity = Constants.showStatusShadowOpacity
        showStatusButton.layer.shadowRadius = Constants.showStatusShadowRadius
        
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
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
        self.backgroundColor = .lightGray
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupNick()
        setupStatus()
        setupShowStatusButton()
        setupTextField()
        
        setupLayout()
    }
    
    private func setupLayout() {
        let navBarHeight = CGFloat(self.safeAreaInsets.top)
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.rightIndentAvatarView),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topIndentAvatarView + navBarHeight),
            avatarImageView.heightAnchor.constraint(equalToConstant: self.frame.width/3),
            avatarImageView.widthAnchor.constraint(equalToConstant: self.frame.width/3),
            
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.rightIndentLabelView + navBarHeight),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            
            statusView.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusView.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 40),
            
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.rightIndentLabelView),
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.rightIndentLabelView),
            showStatusButton.heightAnchor.constraint(equalToConstant: Constants.showStatusButtonHeight),
            showStatusButton.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: Constants.topIndentshowStatusButton),
            
            textField.leadingAnchor.constraint(equalTo: statusView.leadingAnchor, constant: -10),
            textField.trailingAnchor.constraint(equalTo: showStatusButton.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -5),
            textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
        ])
    }
    
    private func setupImage() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: Constants.avatarImageName)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.borderWidth = Constants.avatarImageBorderWidth
        avatarImageView.layer.borderColor = Constants.avatarImageViewBorderColor
        self.addSubview(avatarImageView)
    }
    
    private func setupNick() {
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Hipster Cat"
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
    
    @objc func buttonPressed() {
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


