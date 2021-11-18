//
//  FeedView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class FeedView: UIView {
    
    let stack = UIStackView()
    lazy var firstButton: UIButton = {
        firstButton = UIButton()
        firstButton.setTitle("Первая кнопка", for: .normal)
        firstButton.backgroundColor = .systemCyan
        
        return firstButton
    }()
    
    lazy var secondButton: UIButton = {
        secondButton = UIButton()
        secondButton.setTitle("Вторая кнопка", for: .normal)
        secondButton.backgroundColor = .systemPink
        
        return secondButton
    }()
    
    private enum Constants{
        static let buttomWidth: Double = 150
        static let buttomHeight: Int = 44
    }
    
    var postButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupStack()
        
        setupLayout()
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setupStack(){
        stack.translatesAutoresizingMaskIntoConstraints = false
        setupFirstButton()
        setupSecondButton()
        stack.axis = .vertical
        stack.spacing = 10
        self.addSubview(stack)
    }
    
    private func setupFirstButton() {
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(firstButton)
    }
    
    private func setupSecondButton(){
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(secondButton)
    }
}

