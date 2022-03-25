//
//  TabBar.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

public enum Constans {
    static let feedTitle: String = "Feed"
    static let profileTitle: String = "Profile"
    static let feedImageName: String = "list.bullet.rectangle.fill"
    static let profileImageName: String = "person"
}

class TabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
