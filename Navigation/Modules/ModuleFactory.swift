//
//  FeedFactory.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 30.03.2022.
//

import Foundation


struct ModuleFactory {
    static func buildFeed() -> FeedViewController {
        let presenter = FeedPresenter()
        let viewController = FeedViewController(output: presenter, view: presenter.feedView)
        
        presenter.input = viewController
        
        return viewController
    }
    
    static func buildLogin() -> LogInViewController {
        return LogInViewController()
    }
    
    static func buildPost() -> PostViewController {
        return PostViewController()
    }
    
    static func buildStatus() -> StatusViewController{
        return StatusViewController()
    }
    
    static func buildPhotos() -> PhotosViewController {
        return PhotosViewController()
    }
    
    static func buildProfile(photosTapped: @escaping (() -> Void), userService: User, name:String) -> ProfileViewController {
        let viewModel = ProfileViewModel()
        viewModel.photosTapped = photosTapped
        
        return ProfileViewController(viewModel: viewModel, userService: userService, name: name)
    }
}
