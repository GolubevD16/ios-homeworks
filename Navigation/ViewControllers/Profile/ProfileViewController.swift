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
        navigationController?.navigationBar.isHidden = true
        view.addSubview(tableView)
        tableView.toAutoLayout()
        profileHeaderView.toAutoLayout()
        tableView.tableHeaderView = profileHeaderView
        
        setupLayout()
    
        profileHeaderView.layoutIfNeeded()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .PostTableId)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: .photosTableId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .photosTableId, for: indexPath) as? PhotoTableViewCell else { fatalError() }
            cell.firstPhoto.image = UIImage(named: "slon")
            cell.secondPhoto.image = UIImage(named: "dragon")
            cell.thirdPhoto.image = UIImage(named: "airbus")
            cell.fourthPhoto.image = UIImage(named: "belka")
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .PostTableId, for: indexPath) as? TableViewCell else { fatalError() }
            let post: Post = posts[indexPath.row]
            cell.autor.text = post.author
            cell.imageViewPost.image = UIImage(named: post.image)
            cell.descriptionPost.text = post.description
            cell.likesPost.text = "Likes: \(post.likes)"
            cell.viewsPost.text = "Views: \(post.views)"
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photoVc = PhotosViewController()
            self.navigationController?.pushViewController(photoVc, animated: true)
        }
    }
}

private extension String {
    static let PostTableId = "PostTableViewCellReuseID"
    static let photosTableId = "PhotosTableViewCellReuseID"
}
