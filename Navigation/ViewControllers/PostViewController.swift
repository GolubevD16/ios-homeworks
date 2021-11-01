//
//  PostViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.54, green: 0.35, blue: 0.84, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Status", style: .plain, target: self, action: #selector(goToInfo(sender:)))

        // Do any additional setup after loading the view.
    }
    
    func setupTitle(_ post: Post){
        self.title = post.title
        //self.
    }
    
    @objc func goToInfo(sender: UIBarButtonItem) {
        let infoVc: StatusViewController = StatusViewController()
        present(infoVc, animated: true, completion: nil)
    }
}
