//
//  TableViewCell.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 11.11.2021.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    lazy var autor: UILabel = {
        autor = UILabel(frame: .zero)
        autor.font = UIFont.boldSystemFont(ofSize: 20)
        autor.textColor = UIColor.appTextColor
        autor.numberOfLines = 2
        autor.toAutoLayout()
        
        return autor
    }()
    
    lazy var imageViewPost: UIImageView = {
        imageViewPost = UIImageView()
        imageViewPost.contentMode = .scaleAspectFit
        imageViewPost.backgroundColor = .black
        imageViewPost.toAutoLayout()
        
        return imageViewPost
    }()
    
    lazy var descriptionPost: UILabel = {
        descriptionPost = UILabel(frame: .zero)
        descriptionPost.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        descriptionPost.textColor = UIColor.appTextColor
        descriptionPost.numberOfLines = 0
        descriptionPost.toAutoLayout()
        
        return descriptionPost
    }()
    
    lazy var likesPost: UILabel = {
        likesPost = UILabel(frame: .zero)
        likesPost.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likesPost.textColor = UIColor.appTextColor
        likesPost.toAutoLayout()
        
        return likesPost
    }()
    
    lazy var viewsPost: UILabel = {
        viewsPost = UILabel(frame: .zero)
        viewsPost.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        viewsPost.textColor = UIColor.appTextColor
        viewsPost.toAutoLayout()
        
        return viewsPost
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([autor, imageViewPost, descriptionPost, likesPost, viewsPost])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            autor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            autor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            autor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            
            imageViewPost.topAnchor.constraint(equalTo: autor.bottomAnchor, constant: .padding),
            imageViewPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViewPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViewPost.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            imageViewPost.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            descriptionPost.topAnchor.constraint(equalTo: imageViewPost.bottomAnchor, constant: .padding),
            descriptionPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            descriptionPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),

            likesPost.topAnchor.constraint(equalTo: descriptionPost.bottomAnchor, constant: .padding),
            likesPost.leadingAnchor.constraint(equalTo: descriptionPost.leadingAnchor),
            likesPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
            
            viewsPost.topAnchor.constraint(equalTo: descriptionPost.bottomAnchor, constant: .padding),
            viewsPost.trailingAnchor.constraint(equalTo: descriptionPost.trailingAnchor),
            viewsPost.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
        ])
    }
}

private extension CGFloat {
    static let padding: CGFloat = 16
}
