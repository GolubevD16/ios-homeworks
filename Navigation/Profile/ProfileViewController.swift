//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileHeaderView!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        view.backgroundColor = .lightGray

    }
    
    override func loadView() {
        super.loadView()
        setupProfile()
    }
    
    private func setupProfile() {
        profileView = ProfileHeaderView(frame: self.view.frame)
        //profileView.backgroundColor = UIColor.init(red: 0.07, green: 0.73, blue: 0.82, alpha: 1)
        view.addSubview(profileView)
        self.viewWillLayoutSubviews()
        
    }

}
