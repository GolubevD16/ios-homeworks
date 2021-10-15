//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 15.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profileView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView{
            profileView.frame = CGRect(x: 0, y: 5, width: view.frame.size.width, height: view.frame.size.height)
            view.addSubview(profileView)
        }
    }
}
