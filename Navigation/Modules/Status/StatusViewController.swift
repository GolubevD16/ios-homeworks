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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let statusView = StatusView(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30))
        statusView.delegate = self
        view.addSubview(statusView)
    }
}

extension StatusViewController: ShowAlert{
    func showAlert() {
        let alert = UIAlertController(title: "Вы нажали большую красную кнопку 0_о", message: "Хотите узнать, что будет дальше?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { alert -> Void in
            print("Бум")
        }
        ))
        alert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: { alert -> Void in
            print("Нет, так нет")
        }))
        present(alert, animated: true, completion: nil)
    }
}
