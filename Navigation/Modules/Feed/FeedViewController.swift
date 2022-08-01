//
//  FeedViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    var feedView: FeedView
    var output: FeedPresenterOutput
    var buttonPressed: (() -> Void)?{
        didSet{
            output.buttonPressed = buttonPressed
        }
    }
    
    var mapPressed: (() -> Void)?{
        didSet{
            output.mapPressed = mapPressed
        }
    }
    
    init(output: FeedPresenterOutput, view: FeedView){
        self.output = output
        self.feedView = view
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutFeedView()
        view.backgroundColor = UIColor.appTintColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLayoutFeedView() {
        view.addSubview(feedView)
        feedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
}

extension FeedViewController: FeedPresenterInput{

}
