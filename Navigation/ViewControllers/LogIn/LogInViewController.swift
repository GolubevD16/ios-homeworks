//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.11.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    lazy var loginView: LoginView = {
        loginView = LoginView()
        loginView.delegate = self
        view.addSubview(loginView)
        
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        setupLayoutLoginView()
        registerForKeyboardNotification()
    }
    
    deinit{
        removeForKeyboardNotification()
    }
    
    private func setupLayoutLoginView(){
        loginView.toAutoLayout()
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         ])
    }
    
    private func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let scrolSize = self.loginView.logInButton.frame.maxY + keyboardSize.height - self.view.bounds.maxY + 8 + self.view.safeAreaInsets.top
        loginView.scrollView.contentSize = CGSize(width: loginView.bounds.width, height: loginView.bounds.height + scrolSize)
        loginView.scrollView.contentOffset = CGPoint(x: 0, y: scrolSize)
        loginView.scrollView.isScrollEnabled = true
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        loginView.scrollView.contentSize = CGSize(width: loginView.bounds.width, height: loginView.bounds.height - keyboardSize.height)
        loginView.scrollView.isScrollEnabled = false
    }
}

extension LogInViewController: LogInViewControllerDelegate {
    
    func tappedButton(sender: UIButton) {
        let profileVc = ProfileViewController()
        navigationController?.pushViewController(profileVc, animated: true)
    }
}
