//
//  FeedView.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.10.2021.
//

import UIKit

class FeedView: UIView {
    
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
        setupButton()
        

        //postButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func setupButton() {
        postButton = UIButton(type: .roundedRect)
        postButton.frame = CGRect(x: Double(self.frame.size.width/2) - Constants.buttomWidth/2, y: Double(self.frame.size.height/2) - Double(Constants.buttomHeight/2), width: Constants.buttomWidth, height: Double(Constants.buttomHeight))
        postButton.setTitle("Просмотреть пост", for: .normal)
        postButton.setTitleColor(.blue, for: .normal)
        self.addSubview(postButton)
        
    }
}

