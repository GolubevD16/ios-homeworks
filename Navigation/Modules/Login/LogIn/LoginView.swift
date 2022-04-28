//
//  LoginView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.11.2021.
//

import UIKit

class LoginView: UIView {
    var delegate: LogInViewControllerDelegate?
    var bruteForceDelegate: BruteForce?
    weak var checkerDelegate: LogInViewControllerCheckerDelegate?
    
    let stackView = UIStackView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        activity = UIActivityIndicatorView()
        activity.toAutoLayout()
        
        return activity
    }()
    
    lazy var logoView: UIImageView = {
        logoView = UIImageView(image: UIImage(named: "logo"))
        logoView.toAutoLayout()
        
        return logoView
    }()
    
    lazy var logInButton: CustomButton = {
        let color: UIImage? = UIImage(named: "blue_pixel")
        logInButton = CustomButton(title: "Log in", titleColor: .white, onTap: { [weak self] in
            self?.tappedButton(sender: self?.logInButton ?? UIButton())
        })
        logInButton.setBackgroundImage(color?.image(alpha: 1), for: .normal)
        logInButton.setBackgroundImage(color?.image(alpha: 0.8), for: [.selected, .highlighted, .disabled])
        
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.toAutoLayout()
        
        
        return logInButton
    }()
    
    lazy var bruteForce: CustomButton = {
        let color: UIImage? = UIImage(named: "blue_pixel")
        bruteForce = CustomButton(title: "Подобрать пароль", titleColor: .white, onTap: {[weak self] in
            self?.tappedBruteForce()
        })
        bruteForce.setBackgroundImage(color?.image(alpha: 1), for: .normal)
        bruteForce.setBackgroundImage(color?.image(alpha: 0.8), for: [.selected, .highlighted, .disabled])
        
        bruteForce.layer.cornerRadius = 10
        bruteForce.layer.masksToBounds = true
        bruteForce.toAutoLayout()
        
        
        return bruteForce
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStack()
        scrollView.addSubviews([logoView, logInButton, bruteForce])
        self.addSubviews([scrollView])
        scrollView.contentSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        scrollView.isScrollEnabled = false
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout(){
        passwordTextField.addSubview(activity)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            logoView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 100),
            logoView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            
            bruteForce.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            bruteForce.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            bruteForce.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            bruteForce.heightAnchor.constraint(equalToConstant: 50),
            
            activity.topAnchor.constraint(equalTo: passwordTextField.topAnchor),
            activity.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -8),
            activity.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            activity.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    private func setupStack(){
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addEmailTextField()
        addPasswordTextField()
        
        scrollView.addSubview(stackView)
    }
    
    private func addEmailTextField(){
        emailTextField.toAutoLayout()
        emailTextField.backgroundColor = .systemGray6
        emailTextField.textColor = .black
        emailTextField.placeholder = "Email or phone number"
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.autocapitalizationType = .none
        
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailTextField.setLeftPaddingPoints(16)
        
        stackView.addArrangedSubview(emailTextField)
    }
    
    private func addPasswordTextField(){
        passwordTextField.toAutoLayout()
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.placeholder = "Password"
        passwordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        passwordTextField.setLeftPaddingPoints(16)
        
        stackView.addArrangedSubview(passwordTextField)
    }
    
    func tappedButton(sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        checkerDelegate?.checkLoginPasswordAvailability(inputLogin: emailText, inputPassword: passwordText)
//        if !emailText.isEmpty && !passwordText.isEmpty &&  isAvaiability{
//            delegate?.tappedButton(sender: sender, name: emailTextField.text ?? "")
//        } else {
//            animateButton()
//        }
    }
    
    private func tappedBruteForce() {
        activity.startAnimating()
        passwordTextField.isSecureTextEntry = false
        
        guard let pswd = bruteForceDelegate?.password else {return}
        let concurrentQueue = DispatchQueue(label: "concurrent", qos: .userInteractive, attributes: .concurrent)
        concurrentQueue.async {
            guard let pass = self.bruteForceDelegate?.unlockPassword(password: pswd) else {return}
            self.changePassword(pass)
        }
    }
    
    func changePassword(_ password: String){
        DispatchQueue.main.sync {
            self.passwordTextField.text = password
            self.activity.stopAnimating()
            self.layoutIfNeeded()
        }
    }
    
    func animateButton() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.logInButton.layer.borderWidth = 2
            self?.logInButton.layer.borderColor = UIColor.red.cgColor
            self?.layoutIfNeeded()
        }
    }
}
