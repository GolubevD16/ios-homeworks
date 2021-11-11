//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let posts = PostData.getPosts()
    
    lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        
        return profileHeaderView
    }()
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.toAutoLayout()
        profileHeaderView.toAutoLayout()
        tableView.tableHeaderView = profileHeaderView
        
        setupLayout()
    
        profileHeaderView.layoutIfNeeded()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .tableId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
            profileHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .tableId, for: indexPath) as? TableViewCell else {
            fatalError()
        }
        let post = posts[indexPath.row]
        
        cell.autor.text = post.author
        cell.imageViewPost.image = UIImage(named: post.image)
        cell.descriptionPost.text = post.description
        cell.likesPost.text = "Likes: \(post.likes)"
        cell.viewsPost.text = "Views: \(post.views)"
        
        return cell
    }
}

private extension String {
    static let tableId = "TableViewCellReuseID"
}
