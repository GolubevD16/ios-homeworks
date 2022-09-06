//
//  LogInViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.11.2021.
//

import UIKit

protocol BruteForce{
    var password: String! { get }
    func unlockPassword(password: String) -> String
}

class LogInViewController: UIViewController {
    /// установка длины пароля
    let lenthOfGenerationPassword = 3
    let model = BruteForceModel()
    var checkerDelegate: LogInViewControllerCheckerDelegate?
    var buttonPressed: ((User, String) -> Void)?
    var password: String!
    private let localAuthorizationService = LocalAuthorizationService()
    
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
        view.backgroundColor = UIColor.appTintColor
        //checkAuth()
        generatePassword(lenthOfGenerationPassword)
        setupLayoutLoginView()
        registerForKeyboardNotification()
        loginView.delegate = self
    }
    
    deinit{
        removeForKeyboardNotification()
    }
    
    private func checkAuth(){
        if DataProvider.checkAuth(){
            let currentUser = User(fullName: "not specified".localized, avatar: "belka", status: "set the status".localized)
            buttonPressed?(currentUser, "not specified".localized)
        }
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
    
    private func makeAlert(mess: String){
        let alert = UIAlertController(title: "Attention".localized, message: mess, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)

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
    func registr() {
        let currentUser = User(fullName: "not specified".localized, avatar: "belka", status: "set the status".localized)
        buttonPressed?(currentUser, "not specified".localized)
        makeAlert(mess: "A new user has been registered".localized)
    }
    
    func notAllField() {
        loginView.animateButton()
        makeAlert(mess: "Fill in all the fields".localized)
    }
    
    func weakPass() {
        loginView.animateButton()
        makeAlert(mess: "The password must contain at least 6 characters".localized)
    }
    
    func badEmail() {
        loginView.animateButton()
        makeAlert(mess: "Incorrect Email has been entered".localized)
    }
    
    func passFail() {
        loginView.animateButton()
        makeAlert(mess: "Invalid password entered".localized)
    }
    
    func login() {
        let currentUser = User(fullName: "not specified".localized, avatar: "belka", status: "set the status".localized)
        buttonPressed?(currentUser, "not specified".localized)
        makeAlert(mess: "You have successfully logged in".localized)
    }
    
    func biometric() {
        localAuthorizationService.authorizeIfPossible { [unowned self] result in
            switch result {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.login()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func tappedButton(sender: UIButton, name: String) {
//        var currentUser: UserService
//#if DEBUG
//            currentUser = TestUserService()
//#else
//           let user = User(
//                        fullName: name,
//                        avatar: "belka",
//                        status: "Waiting for something..."
//                        )
//           currentUser = CurrentUserService(user: user)
//#endif
//        buttonPressed?(currentUser, name)
    }
}

extension LogInViewController: BruteForce{
    func unlockPassword(password: String)-> String {
        return model.bruteForce(passwordToUnlock: password)
    }
}
