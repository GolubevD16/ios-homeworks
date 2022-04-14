//
//  Coordinators.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 24.03.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject{
    func start()
}

protocol FinishingCoordinator: Coordinator{
    var onfinish: (() -> Void)? {get set}
}

class BaseCoordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    func addDependency(_ coordinator: Coordinator){
        for element in childCoordinators{
            if element === coordinator {return}
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?){
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else {return}
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator{
                childCoordinators.remove(at: index)
            break
            }
        }
    }
    
    func removeAll() {
        childCoordinators.removeAll()
    }
}

// MARK: TabBarCoordinator
final class TabBarCoordinator: BaseCoordinator, Coordinator{
    var window: UIWindow?
    private let scene: UIWindowScene
    private let FeedNavController = UINavigationController(rootViewController: ModuleFactory.buildFeed())
    private let LoginNavController = UINavigationController(rootViewController: ModuleFactory.buildLogin())
    private let tabBar = TabBar()
    
    init(scene: UIWindowScene){
        self.scene = scene
        super.init()
    }
    
    func start() {
        initWindow()
        setUpTabBar()
        let loginVC = LoginNavController.viewControllers[0] as? LogInViewController
        loginVC?.buttonPressed = {[weak self] user, name in
            self?.showProfileVC(user: user, name: name)
        }
        
        let feedVC = FeedNavController.viewControllers.last as? FeedViewController
        feedVC?.buttonPressed = {[weak self] in
            self?.showFeedVC()
        }
    }
    
    private func showProfileVC(user: UserService, name: String){
        let coordinator = ProfileCoordinator(navController: LoginNavController, currentUser: user, name: name)
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func showFeedVC(){
        let coordinator = PostCoordinator(navController: FeedNavController)
        coordinator.start()
    }
    
    private func initWindow(){
        let window = UIWindow(windowScene: scene)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setUpTabBar(){
        setUpNavControllers()
        tabBar.viewControllers = [FeedNavController, LoginNavController]
    }
    
    private func setUpNavControllers(){
        FeedNavController.tabBarItem.title = Constans.feedTitle
        FeedNavController.tabBarItem.image = UIImage(systemName: Constans.feedImageName) ?? UIImage()
        FeedNavController.topViewController?.title = Constans.feedTitle
        updateNavBarAppearance(navController: FeedNavController)
        
        LoginNavController.tabBarItem.title = Constans.profileTitle
        LoginNavController.tabBarItem.image = UIImage(systemName: Constans.profileImageName) ?? UIImage()
        LoginNavController.topViewController?.title = Constans.profileTitle
        updateNavBarAppearance(navController: LoginNavController)
    }
    
    @available(iOS 15.0, *)
    private func updateNavBarAppearance(navController: UINavigationController) {
        let navBarAppearance: UINavigationBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        
        let navTintColor: UIColor = .white
        navBarAppearance.backgroundColor = navTintColor
        
        navController.navigationBar.standardAppearance = navBarAppearance
        navController.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}


// MARK: PostCoordinator
final class PostCoordinator: FinishingCoordinator{
    private weak var navController: UINavigationController?
    var onfinish: (() -> Void)?
    
    init(navController: UINavigationController){
        self.navController = navController
    }
    
    func start() {
        initWindow()
        let postVC = navController?.viewControllers.last as? PostViewController
        postVC?.statusTapped = showStatus(postVC:)
    }
    
    private func initWindow(){
        let postVC = ModuleFactory.buildPost()
        navController?.pushViewController(postVC, animated: true)
    }
    
    private func showStatus(postVC: PostViewController?){
        guard let postVC = postVC else {return}
        let coordinator = StatusCoordinator(postVC)
        coordinator.start()
    }
}

// MARK: StatusCoordinator
final class StatusCoordinator: FinishingCoordinator{
    var onfinish: (() -> Void)?
    let vc: PostViewController
    
    init(_ vc: PostViewController){
        self.vc = vc
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow(){
        let statusVC = ModuleFactory.buildStatus()
        vc.present(statusVC, animated: true, completion: nil)
    }
    
}


// MARK: ProfileCoordinator
final class ProfileCoordinator: FinishingCoordinator{
    private weak var navController: UINavigationController?
    private let currentUser: UserService
    private let name: String
    var onfinish: (() -> Void)?
    
    init(navController: UINavigationController, currentUser: UserService, name: String){
        self.navController = navController
        self.currentUser = currentUser
        self.name = name
    }
    
    func start() {
        initWindow()
        let profileVC = navController?.viewControllers.last as? ProfileViewController
        profileVC?.photosTapped = {[weak self] in
            self?.showPhotos()}
    }
    
    private func initWindow(){
        let profileVc = ModuleFactory.buildProfile(photosTapped: self.showPhotos, userService: currentUser, name: name)
        navController?.pushViewController(profileVc, animated: true)
    }
    
    private func showPhotos(){
        let coordinator = PhotosCoordinator(navController: navController)
        coordinator.start()
    }
}


// MARK: PhotosCoordinator
final class PhotosCoordinator: FinishingCoordinator{
    private weak var navController: UINavigationController?
    var onfinish: (() -> Void)?
    
    init(navController: UINavigationController?){
        self.navController = navController
    }
    
    func start() {
        initWindow()
    }
    
    private func initWindow(){
        let photoVc = ModuleFactory.buildPhotos()
        navController?.pushViewController(photoVc, animated: true)
    }
}

