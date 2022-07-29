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
        let alert = UIAlertController(title: "You have pressed the big red button 0_o", message: "Do you want to know what will happen next?", preferredStyle: .alert)
        // Вы нажали большую красную кнопку 0_о
        // Хотите узнать, что будет дальше?
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert -> Void in
            print("Boom")
        }
        ))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { alert -> Void in
            print("No, it's no")
        }))
        present(alert, animated: true, completion: nil)
    }
}
