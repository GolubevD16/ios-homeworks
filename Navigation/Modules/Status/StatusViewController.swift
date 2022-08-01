//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

protocol ShowAlert{
    func showAlert() -> ()
}

class StatusViewController: UIViewController {
    
    lazy var model = StatusModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let statusView = StatusView(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30))
        model.status = statusView
        model.setTitlePeople()
        model.setTitlePlanet()
        statusView.delegate = self
        view.addSubview(statusView)
        //StatusModel.setTitle()
    }
    
}

extension StatusViewController: ShowAlert{
    func showAlert() {
        let alert = UIAlertController(title: "You have pressed the big red button 0_o".localized, message: "Do you want to know what will happen next?".localized, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes".localized, style: .default, handler: { alert -> Void in
            print("Boom".localized)
        }
        ))
        alert.addAction(UIAlertAction(title: "No".localized, style: .cancel, handler: { alert -> Void in
            print("No, it's no".localized)
        }))
        present(alert, animated: true, completion: nil)
    }
}
