//
//  FeedView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class FeedView: UIView {
    var delegate: NextVC?
    
    let stack = UIStackView()
    lazy var firstButton: CustomButton = {
        firstButton = CustomButton(title: "Первая кнопка", titleColor: .white, onTap: delegate?.nextVC)
        firstButton.backgroundColor = .systemCyan
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        
        return firstButton
    }()
    
    lazy var secondButton: CustomButton = {
        secondButton = CustomButton(title: "Вторая кнопка", titleColor: .white, onTap: delegate?.nextVC)
        secondButton.backgroundColor = .systemPink
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        
        return secondButton
    }()
    
    lazy var customTextField: UITextField = {
        customTextField = UITextField()
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        customTextField.backgroundColor = .cyan
        customTextField.placeholder = "password"
        
        return customTextField
    }()
    
    lazy var btn: CustomButton = {
        btn = CustomButton(title: "click", titleColor: .black, onTap: { [weak self] in
            self?.changedTextTapped()
        })
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var checkLabel: UILabel = {
        checkLabel = UILabel()
        checkLabel.backgroundColor = .white
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return checkLabel
    }()
    
    private enum Constants{
        static let buttomWidth: Double = 150
        static let buttomHeight: Int = 44
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(checkPassword), name: .checkPassword, object: nil)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
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
            checkLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupStack(){
        stack.translatesAutoresizingMaskIntoConstraints = false
        setup()
        stack.axis = .vertical
        stack.spacing = 10
        self.addSubview(stack)
    }
    
    private func setup() {
        stack.addArrangedSubview(checkLabel)
        stack.addArrangedSubview(firstButton)
        stack.addArrangedSubview(secondButton)
        stack.addArrangedSubview(customTextField)
        stack.addArrangedSubview(btn)
    }
    
    @objc func checkPassword(notification: Notification){
        guard let isCorrect = notification.object as? Bool else { return }
        isCorrect ? animateGreen() : animateRed()
    }
    
    private func animateRed() {
            UIView.animate(withDuration: 0.5) {
                [weak self] in
                self?.checkLabel.textColor = .red
                self?.checkLabel.text = "Uncorrect"
                self?.checkLabel.textAlignment = .center
                self?.layoutIfNeeded()
        }
    }
        
    private func animateGreen() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.checkLabel.textColor = .green
            self?.checkLabel.text = "Correct"
            self?.checkLabel.textAlignment = .center
            self?.layoutIfNeeded()
        }
    }
    
    func changedTextTapped()  {
        guard let text = customTextField.text, !text.isEmpty else { return }
        delegate?.checkWord(word: text)
    }
    
    func clickButton() {
        delegate?.nextVC()
    }
}

