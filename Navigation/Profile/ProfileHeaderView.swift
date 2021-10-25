//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 19.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private enum Constants {
        static let avatarImageName: String = "hipster cat"
        static let avatarImageViewFrame: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        static let avatarImageBorderWidth: CGFloat = 3.0
        static let avatarImageViewBorderColor: CGColor = UIColor.white.cgColor
        static let topIndentAvatarView: CGFloat = 16.0
        static let rightIndentAvatarView: CGFloat = 16.0
        static let rightIndentLabelView: CGFloat = 27.0
        static let nameLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let nameLabelColor: UIColor = .black
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
        setupNick()
        setupLayoutProfile()
        
        
        
        //test.frame = CGRect(x: 0, y: self.safeAreaInsets.top, width: 100, height: 100)
        //test.backgroundColor = .green
}
    
    private func setupLayoutProfile() {
        
        let navBarHeight = CGFloat(self.safeAreaInsets.top)
        let viewVFL = ["avatar": avatarImageView, "label": nickView]
        let metrics = ["topAvatar" : Constants.topIndentAvatarView + navBarHeight, "right": Constants.rightIndentAvatarView, "topLabel" : Constants.rightIndentLabelView + navBarHeight]
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-topAvatar-[avatar(150)]|", options: [], metrics: metrics, views: viewVFL))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-right-[avatar(150)]-(20)-[label(100)]|", options: [], metrics: metrics, views: viewVFL))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-topLabel-[label(20)]|", options: [], metrics: metrics, views: viewVFL))
        

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
        nickView.font = Constants.nameLabelFont
        nickView.textColor = Constants.nameLabelColor
        self.addSubview(nickView)
    }
}


