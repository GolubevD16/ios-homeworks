//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileHeaderView!
    private var textStatus = ""
    
    lazy var newButton: UIButton = {
        newButton = UIButton()
        newButton.setTitle("New button", for: .normal)
        newButton.backgroundColor = .red

        return newButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
        setupNewButton()
        setupLayoutProfileView()
    }
    
    override func loadView() {
        super.loadView()
        
    }
    
    private func setupProfile() {
        profileView = ProfileHeaderView(frame: self.view.frame)
        profileView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileView.textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        view.addSubview(profileView)
    }
    
    private func setupLayoutProfileView() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.heightAnchor.constraint(equalToConstant: 220),
            newButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            newButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            newButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
         ])
    }
    
    private func setupNewButton(){
        newButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(newButton)
    }
    
    private func statusTextFieldAnimate() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.profileView.textField.layer.borderWidth = 2
            self?.profileView.textField.layer.borderColor = UIColor.red.cgColor
            self?.view.layoutIfNeeded()
        }
    }
    
    private func returnStatusTextFieldAnimate() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.profileView.textField.layer.borderWidth = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func buttonPressed() {
        //print(profileView.statusView.text ?? "Error") для задания без звёздочки
        if textStatus != ""{
            profileView.statusView.text = textStatus
            returnStatusTextFieldAnimate()
        }
        else {
            statusTextFieldAnimate()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField){
        guard let text = textField.text else { return }
        textStatus = text
    }
}
