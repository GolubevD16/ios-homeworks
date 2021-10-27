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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProfile()
        view.addSubview(profileView)
        setupLayoutProfileView()
        
        
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .lightGray
        
    }
    
    private func setupProfile() {
        
        profileView = ProfileHeaderView(frame: self.view.frame)
        profileView.showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileView.textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        
        
    }
    
    private func setupLayoutProfileView() {
        profileView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
    }
    
    @objc func buttonPressed() {
        //print(profileView.statusView.text ?? "Error") для задания без звёздочки
        profileView.statusView.text = textStatus
    }
    
    @objc func statusTextChanged(_ textField: UITextField){
        guard let text = textField.text else { return }
        textStatus = text
    }
}
