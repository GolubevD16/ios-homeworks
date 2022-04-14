//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.11.2021.
//

import UIKit

protocol BruteForce{
    var password: String! {get }
    func unlockPassword(password: String) -> String
}

class LogInViewController: UIViewController {
    /// установка длины пароля
    let lenthOfGenerationPassword = 8
    let model = BruteForceModel()
    var checkerDelegate: LogInViewControllerCheckerDelegate?
    var buttonPressed: ((UserService, String) -> Void)?
    var password: String!
    
    lazy var loginView: LoginView = {
        loginView = LoginView()
        loginView.checkerDelegate = checkerDelegate
        loginView.bruteForceDelegate = self
        view.addSubview(loginView)
        
        return loginView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        generatePassword(lenthOfGenerationPassword)
        print(password!)
        setupLayoutLoginView()
        registerForKeyboardNotification()
        loginView.delegate = self
    }
    
    deinit{
        removeForKeyboardNotification()
    }
    
    private func generatePassword(_ lenth: Int){
        let randomCharacters = (0..<lenth).map{_ in String().printable.randomElement()!}
        password = String(randomCharacters)
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
    
    func tappedButton(sender: UIButton, name: String) {
        var currentUser: UserService
#if DEBUG
            currentUser = TestUserService()
#else
           let user = User(
                        fullName: name,
                        avatar: "belka",
                        status: "Waiting for something..."
                        )
           currentUser = CurrentUserService(user: user)
#endif
        buttonPressed?(currentUser, name)
    }
}

extension LogInViewController: BruteForce{
    func unlockPassword(password: String)-> String {
        return model.bruteForce(passwordToUnlock: password)
    }
}
