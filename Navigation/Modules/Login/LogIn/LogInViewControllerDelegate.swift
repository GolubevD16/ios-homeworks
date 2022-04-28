//
//  LogInViewControllerDelegate.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 09.11.2021.
//

import Foundation
import UIKit

protocol LogInViewControllerDelegate {
    func tappedButton(sender: UIButton, name: String)
    func registr()
    func notAllField()
    func badEmail()
    func passFail()
    func login()
    func weakPass()
}

protocol LogInViewControllerCheckerDelegate: AnyObject {
    func checkLoginPasswordAvailability(inputLogin: String, inputPassword: String)
}
