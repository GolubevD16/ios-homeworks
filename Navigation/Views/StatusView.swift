//
//  Status.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class StatusView: UIView {
    
    private enum Constants{
        static let buttomWidth: Double = 250
        static let buttomHeight: Int = 44
    }
    
    var alertButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    private func setupButton() {
        alertButton = UIButton(type: .roundedRect)
        alertButton.frame = CGRect(x: Double(self.frame.size.width/2) - Constants.buttomWidth/2, y: Double(self.frame.size.height/2) - Double(Constants.buttomHeight/2), width: Constants.buttomWidth, height: Double(Constants.buttomHeight))
        alertButton.setTitle("Большая красная кнопка", for: .normal)
        alertButton.setTitleColor(.white, for: .normal)
        alertButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        alertButton.layer.backgroundColor = UIColor.red.cgColor
        self.addSubview(alertButton)
        
    }
    
}
