//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit
import StorageService
import iOSIntPackage

class ProfileViewController: UIViewController {
    
    //private let posts = PostData.getPosts()
    var userService: UserService
    var name: String
    var photosTapped: (() -> Void)?
    var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel, userService: UserService, name:String){
        self.viewModel = viewModel
        self.userService = userService
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView()
        
        return profileHeaderView
    }()
    
    lazy var avatarImageView: UIImageView = {
        avatarImageView = UIImageView(image: UIImage(named: "hipster cat"))
        avatarImageView.frame = self.avatarImageView.frame
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        return avatarImageView
    }()
    
    lazy var viewWithAvatar: UIView = {
        viewWithAvatar = UIView()
        viewWithAvatar.frame = self.view.frame
        viewWithAvatar.addSubviews([avatarImageView, closeButton])
        viewWithAvatar.translatesAutoresizingMaskIntoConstraints = false
        
        return viewWithAvatar
    }()
    
    lazy var closeButton : UIButton = {
        closeButton = UIButton()
        closeButton.setImage(UIImage(named: "exit"), for: .normal)
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        closeButton.alpha = 0
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        return closeButton
    }()
    
    var opeNconstraints: [NSLayoutConstraint] = []
    var closeConstraints: [NSLayoutConstraint] = []
    
    lazy var transparentView: UIView = {
        transparentView = UIView()
        transparentView.frame = self.view.frame
        transparentView.backgroundColor = .black
        transparentView.alpha = 0
        
        return transparentView
    }()
    
    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViewModel()
        viewModel.send(.viewIsReady)
        #if DEBUG
        self.view.backgroundColor = .red
        #endif
        view.addSubview(tableView)
        tableView.toAutoLayout()
        profileHeaderView.toAutoLayout()
        configureProfileHeaderView()
        tableView.tableHeaderView = profileHeaderView
        
        
        setupLayout()
    
        profileHeaderView.layoutIfNeeded()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: .PostTableId)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: .photosTableId)
        tableView.dataSource = self
        tableView.delegate = self
        
        let gestureOpen = UITapGestureRecognizer(
            target: self,
            action: #selector(hanbleOpenTapGestureRecognizer)
        )
        let gestureClose = UITapGestureRecognizer(
            target: self,
            action: #selector(hanbleCloseTapGestureRecognizer)
        )
        self.profileHeaderView.avatarImageView.isUserInteractionEnabled = true
        avatarImageView.isUserInteractionEnabled = true
        self.profileHeaderView.avatarImageView.addGestureRecognizer(gestureOpen)
        self.closeButton.addGestureRecognizer(gestureClose)
    }
    
    private func setupViewModel(){
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loaded:
                self.showContent()
                self.tableView.reloadData()
            case .gallaryTapped:
                self.photosTapped?()
            default: break
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 1
        }
    }
    
    private func configureProfileHeaderView() {
            guard let user = userService.getUser(name: name) else { return }
            profileHeaderView.initWithUser(user: user)
    }
    
    @objc private func hanbleOpenTapGestureRecognizer(gesture: UITapGestureRecognizer){
        
        self.profileHeaderView.avatarImageView.alpha = 0.0
        self.view.addSubviews([transparentView, viewWithAvatar])
        setupLayoutViewWithAvatarView()
        setupImage()
        
        let animationCornerRadius = CABasicAnimation(keyPath: "cornerRadius")
        animationCornerRadius.toValue = 0
        animationCornerRadius.duration = 0.5
        animationCornerRadius.isRemovedOnCompletion = false
        animationCornerRadius.fillMode = .forwards
        self.avatarImageView.layer.add(animationCornerRadius, forKey: "avatarViewAnimationCornerRadius")

        UIView.animate(withDuration: 0.5) {
            NSLayoutConstraint.deactivate(self.opeNconstraints)
            NSLayoutConstraint.activate(self.closeConstraints)

            self.view.layoutIfNeeded()
            self.transparentView.alpha = 0.5
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = 1
        }
    }
    
    @objc private func hanbleCloseTapGestureRecognizer(gesture: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3) {
            self.closeButton.alpha = 0
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            NSLayoutConstraint.deactivate(self.closeConstraints)
            NSLayoutConstraint.activate(self.opeNconstraints)

            self.view.layoutIfNeeded()
            self.transparentView.alpha = 0
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300), execute: {
            let animationCornerRadius = CABasicAnimation(keyPath: "cornerRadius")
            animationCornerRadius.fromValue = 0
            animationCornerRadius.toValue = self.avatarImageView.bounds.height / 2
            animationCornerRadius.duration = 0.5
            self.avatarImageView.layer.add(animationCornerRadius, forKey: "avatarViewAnimationCornerRadius")
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800), execute: {
            self.profileHeaderView.avatarImageView.alpha = 1
            self.transparentView.removeFromSuperview()
            self.viewWithAvatar.removeFromSuperview()
            NSLayoutConstraint.deactivate(self.opeNconstraints)
        })
        
    }
    
    private func setupLayoutViewWithAvatarView(){
        let navBarHeight = CGFloat(self.view.safeAreaInsets.top)
        
        let viewConstraints = [
            viewWithAvatar.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewWithAvatar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewWithAvatar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewWithAvatar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ]
        
        opeNconstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: viewWithAvatar.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: viewWithAvatar.topAnchor, constant: 16 + navBarHeight),
            avatarImageView.heightAnchor.constraint(equalToConstant: viewWithAvatar.frame.width/3),
            avatarImageView.widthAnchor.constraint(equalToConstant: viewWithAvatar.frame.width/3),
        ]
        
        closeConstraints = [
            avatarImageView.leadingAnchor.constraint(equalTo: viewWithAvatar.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: viewWithAvatar.trailingAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: viewWithAvatar.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: viewWithAvatar.widthAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: viewWithAvatar.widthAnchor),
        ]
        
        let buttonConstrants = [
            closeButton.trailingAnchor.constraint(equalTo: viewWithAvatar.trailingAnchor, constant: -16),
            closeButton.topAnchor.constraint(equalTo: viewWithAvatar.topAnchor, constant: navBarHeight + 16),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(opeNconstraints + viewConstraints + buttonConstrants)
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    private func setupImage() {
        avatarImageView.clipsToBounds = true

        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLayout()
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
            return viewModel.posts.count
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
            let post: Post = viewModel.posts[indexPath.row]
            cell.autor.text = post.author
            let imageProcessor = ImageProcessor()
            
            guard let image = UIImage(named: post.image) else { return UITableViewCell()}
            guard let filter = ColorFilter.allCases.randomElement() else { return UITableViewCell()}
            DispatchQueue.main.async {
                imageProcessor.processImage(
                    sourceImage: image,
                    filter: filter,
                    completion: { image in
                        cell.imageViewPost.image = image
                    }
                )
            }

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
            viewModel.send(.showGallery)
        }
    }
}

private extension String {
    static let PostTableId = "PostTableViewCellReuseID"
    static let photosTableId = "PhotosTableViewCellReuseID"
}
