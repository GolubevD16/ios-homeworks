//
//  InfoViewController.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 18.10.2021.
//

import UIKit

class StatusViewController: UIViewController {

    var statusView: StatusView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
    override func loadView() {
        super.loadView()
        setupStatus()
    }
    
    private func setupStatus() {
        statusView = StatusView(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30))
        statusView.alertButton.addTarget(self, action: #selector(clickAlertAction(_:)), for: .touchUpInside)
        view.addSubview(statusView)
    }

    
    @objc func clickAlertAction(_ sender: Any) {
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
