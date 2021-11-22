//
//  CollectionViewCell.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.11.2021.
//

import Foundation
import UIKit


final class CollectionViewCell: UICollectionViewCell{
    
    lazy var imageView: UIImageView = {
        imageView = UIImageView()
        imageView.toAutoLayout()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        
        setupLayout()
    }
    
    func addPhoto(photoName: String) {
        imageView.image = UIImage(named: photoName)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
