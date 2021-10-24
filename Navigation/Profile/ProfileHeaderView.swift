//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 19.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
//    private enum Constants {
//        static let logoImage: UIImage? = UIImage(named: "hipster cat")
//        static let logoImageViewFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
//        static let logoImageViewBorderWidth: CGFloat = 3.0
//        static let logoImageViewBorderColor: CGColor = UIColor.white.cgColor
//        static let padding: CGFloat = 16
//    }
    
//    lazy var logoImageView: UIImageView = {
//        logoImageView = UIImageView(image: Constants.logoImage)
//        logoImageView.frame = Constants.logoImageViewFrame
//
//        return logoImageView
//    }()
    
    private enum Constants {
        static let avatarImageName: String = "hipster cat"
        static let avatarImageViewFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        static let avatarImageBorderWidth: CGFloat = 3.0
        static let avatarImageViewBorderColor: CGColor = UIColor.white.cgColor
        static let topIndentAvatarView: CGFloat = 16.0
        static let rightIndentAvatarView: CGFloat = 16.0
        static let nameLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let nameLabelColor: UIColor = .black
        static let statusLabelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let statusLabelColor: UIColor = .gray
    }
    
    var avatarImageView = UIImageView()
    var nickView = UILabel()
    
    let avatarImage = UIImage(named: Constants.avatarImageName)
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
//    private func setupProfileView(){
//        test = UIView()
//        test.translatesAutoresizingMaskIntoConstraints = false
//        test.backgroundColor = .red
//        self.addSubview(test)
//
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImage()
        setupLayoutImage()
        setupNick()
        
        
        
        //test.frame = CGRect(x: 0, y: self.safeAreaInsets.top, width: 100, height: 100)
        //test.backgroundColor = .green
}
    
    private func setupLayoutImage() {
        
        let navBarHeight = Int(self.safeAreaInsets.top)
        let viewVFL = ["avatar": avatarImageView, "label": nickView]
        let metrics = ["top" : Constants.topIndentAvatarView + CGFloat(navBarHeight), "right": Constants.rightIndentAvatarView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[avatar(150)]|", options: [], metrics: metrics, views: viewVFL))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[avatar(150)]|", options: [], metrics: nil, views: viewVFL))

    }
    
    
    private func setupImage() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.backgroundColor = UIColor.red
        avatarImageView.image = UIImage(named: Constants.avatarImageName)
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.borderWidth = Constants.avatarImageBorderWidth
        avatarImageView.layer.borderColor = Constants.avatarImageViewBorderColor
        self.addSubview(avatarImageView)
    }
    
    private func setupNick() {
        nickView.translatesAutoresizingMaskIntoConstraints = false
        nickView.text = "Hipster Cat"
        nickView.font = Constants.statusLabelFont
        nickView.textColor = Constants.statusLabelColor
        self.addSubview(nickView)
    }
}


