//
//  Status.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class StatusView: UIView {
    
    var delegate: ShowAlert?
    
    private enum Constants{
        static let buttomWidth: Double = 250
        static let buttomHeight: Int = 44
    }
    
    lazy var alertButton: CustomButton = {
        alertButton = CustomButton(title: "Большая красная кнопка", titleColor: .white, onTap: delegate?.showAlert)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(alertButton)
        
        
        return alertButton
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        setupButton()
    }
    
    private func setupButton() {
        alertButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        alertButton.layer.backgroundColor = UIColor.red.cgColor
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
