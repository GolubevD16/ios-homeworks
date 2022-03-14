//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

protocol NextVC{
    func nextVC() -> ()
    func checkWord(word: String) -> ()
}

class FeedViewController: UIViewController {
    var feedView: FeedView!
    var model: Model?
    
    private enum Constains {
        static let postTitle: String = "Текст поста"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedView = FeedView(frame: self.view.frame)
        feedView.delegate = self
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
        view.addSubview(feedView)
    }
}

extension FeedViewController: NextVC{
    func checkWord(word: String) {
        model = Model()
        model?.check(word: word)
    }
    
    func nextVC() {
        let postVC: PostViewController = PostViewController()
        postVC.setupTitle(Constains.postTitle)
        navigationController?.pushViewController(postVC, animated: true)
    }
}
