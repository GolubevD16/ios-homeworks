//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    var feedView: FeedView!
    
    private enum Constains {
        static let postTitle: String = "Текст поста"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupFeed()
    }
    

    private func setupFeed() {
        feedView = FeedView(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30))
        feedView.postButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        
        view.addSubview(feedView)
        
    }
    
    @objc func clickButton(_ sender: Any) {
        let post = Post(title: Constains.postTitle)
        let postVC: PostViewController = PostViewController()
        postVC.setupTitle(post)
        navigationController?.pushViewController(postVC, animated: true)
    }

}
