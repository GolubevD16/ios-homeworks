//
//  LikePost.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 27.06.2022.
//

import Foundation
import UIKit

class LikePostViewController: UIViewController{
    
    var posts: [Post] = []
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .PostTableId1)
        tableView.toAutoLayout()
        view.addSubview(tableView)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.shared.getLikedPost(complition: { posts1 in
            posts = posts1
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LikePostViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .PostTableId1, for: indexPath) as? TableViewCell else { fatalError() }
        let post: Post = posts[indexPath.row]
        
        guard let image = UIImage(named: post.image) else { return UITableViewCell()}
        
        cell.imageViewPost.image = image
        cell.autor.text = post.author
        cell.descriptionPost.text = post.description
        cell.likesPost.text = "Likes: \(post.likes)"
        cell.viewsPost.text = "Views: \(post.views)"
        cell.selectionStyle = .none

        return cell
    }
    
}

private extension String {
    static let PostTableId1 = "PostTableViewCellReuseID1"
}
