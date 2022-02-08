//
//  Post.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import Foundation

public struct Post{
    public let author: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, description: String, image: String, likes: Int, views: Int) {
            self.author = author
            self.image = image
            self.description = description
            self.likes = likes
            self.views = views
    }
}
