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
        feedView = FeedView(frame: self.view.frame)
        setupFeed()
        setupLayoutFeedView()
    }
    
    override func loadView() {
        super.loadView()
    }
    
    private func setupLayoutFeedView() {
        feedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
    
    private func setupFeed() {
        feedView.firstButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        feedView.secondButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        view.addSubview(feedView)
    }
    
    @objc func clickButton(_ sender: Any) {
        let postVC: PostViewController = PostViewController()
        postVC.setupTitle(Constains.postTitle)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
