//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.11.2021.
//

import Foundation
import UIKit

final class PhotoTableViewCell: UITableViewCell{
    
    lazy var photosLabel: UILabel = {
        photosLabel = UILabel(frame: .zero)
        photosLabel.font = UIFont.boldSystemFont(ofSize: 24)
        photosLabel.text = "Photos".localized
        photosLabel.textColor = UIColor.appTextColor
        photosLabel.toAutoLayout()

        return photosLabel
    }()
    
    lazy var arrowButton: UIImageView = {
        arrowButton = UIImageView(image: UIImage(systemName: "arrow.right"))
        arrowButton.tintColor = UIColor.appTextColor
        arrowButton.toAutoLayout()
        
        return arrowButton
    }()
    
    lazy var firstPhoto: UIImageView = {
        firstPhoto = UIImageView(frame: .zero)
        firstPhoto.clipsToBounds = true
        firstPhoto.layer.cornerRadius = 6
        firstPhoto.toAutoLayout()
        
        return firstPhoto
    }()
    
    lazy var secondPhoto: UIImageView = {
        secondPhoto = UIImageView(frame: .zero)
        secondPhoto.clipsToBounds = true
        secondPhoto.layer.cornerRadius = 6
        secondPhoto.toAutoLayout()
        
        return secondPhoto
    }()
    
    lazy var thirdPhoto: UIImageView = {
        thirdPhoto = UIImageView(frame: .zero)
        thirdPhoto.clipsToBounds = true
        thirdPhoto.layer.cornerRadius = 6
        thirdPhoto.toAutoLayout()
        
        return thirdPhoto
    }()
    
    lazy var fourthPhoto: UIImageView = {
        fourthPhoto = UIImageView(frame: .zero)
        fourthPhoto.clipsToBounds = true
        fourthPhoto.layer.cornerRadius = 6
        fourthPhoto.toAutoLayout()
        
        return fourthPhoto
    }()
    
    lazy var spacingView: UIView = {
        spacingView = UIView()
        spacingView.backgroundColor = .systemGray5
        spacingView.toAutoLayout()
        
        return spacingView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews([photosLabel, arrowButton, firstPhoto, secondPhoto, thirdPhoto, fourthPhoto, spacingView])
        
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            spacingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            spacingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            spacingView.heightAnchor.constraint(equalToConstant: 10),
            
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowButton.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            
            firstPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            firstPhoto.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            firstPhoto.bottomAnchor.constraint(equalTo: spacingView.topAnchor, constant: -12),
            firstPhoto.heightAnchor.constraint(equalToConstant: .photoSize),
            firstPhoto.widthAnchor.constraint(equalToConstant: .photoSize),
            
            secondPhoto.leadingAnchor.constraint(equalTo: firstPhoto.trailingAnchor, constant: 8),
            secondPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            secondPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor),
            secondPhoto.heightAnchor.constraint(equalToConstant: .photoSize),
            secondPhoto.widthAnchor.constraint(equalToConstant: .photoSize),
            
            thirdPhoto.leadingAnchor.constraint(equalTo: secondPhoto.trailingAnchor, constant: 8),
            thirdPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            thirdPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor),
            thirdPhoto.heightAnchor.constraint(equalToConstant: .photoSize),
            thirdPhoto.widthAnchor.constraint(equalToConstant: .photoSize),
            
            fourthPhoto.leadingAnchor.constraint(equalTo: thirdPhoto.trailingAnchor, constant: 8),
            fourthPhoto.topAnchor.constraint(equalTo: firstPhoto.topAnchor),
            fourthPhoto.bottomAnchor.constraint(equalTo: firstPhoto.bottomAnchor),
            fourthPhoto.heightAnchor.constraint(equalToConstant: .photoSize),
            fourthPhoto.widthAnchor.constraint(equalToConstant: .photoSize),
            ])
    }
}

extension CGFloat{
    static let photoSize = CGFloat((UIScreen.main.bounds.width - 48) / 4)
}
