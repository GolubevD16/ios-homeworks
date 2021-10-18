//
//  TabBar.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class TabBar: UITabBarController {
    
    private enum Constans {
        static let feedTitle: String = "Feed"
        static let profileTitle: String = "Profile"
        static let feedImageName: String = "list.bullet.rectangle.fill"
        static let profileImageName: String = "person"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        
        setUpTabBar()
    }
    
    func setUpTabBar(){
        viewControllers = [createNavigationController(for: FeedViewController(), title: Constans.feedTitle, image: UIImage(systemName: Constans.feedImageName) ?? UIImage()),
                           createNavigationController(for: ProfileViewController(), title: Constans.profileTitle, image: UIImage(systemName: Constans.profileImageName) ?? UIImage())
        ]
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
