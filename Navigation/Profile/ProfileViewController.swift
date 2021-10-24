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
        view.backgroundColor = .lightGray
        self.viewWillLayoutSubviews()
        profileView = ProfileHeaderView()
        
    }
    
    override func loadView() {
        super.loadView()
        setupProfile()
    }
    
    private func setupProfile() {
        profileView = ProfileHeaderView(frame: self.view.frame)
        view.addSubview(profileView)
        self.viewWillLayoutSubviews()
        
    }
    
}
