//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class PostViewController: UIViewController {
    
    var statusTapped: ((_ vc: PostViewController) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.54, green: 0.35, blue: 0.84, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Status", style: .plain, target: self, action: #selector(goToInfo(sender:)))
    }
    
    func setupTitle(_ title: String){
        self.title = title
    }
    
    @objc func goToInfo(sender: UIBarButtonItem) {
        self.statusTapped?(self)
    }
}