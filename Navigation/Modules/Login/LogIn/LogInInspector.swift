//
//  LogInInspector.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.02.2022.
//

import Foundation

final class LogInInspector: LogInViewControllerCheckerDelegate{
    func checkLoginPasswordAvailability(inputLogin: String, inputPassword: String) -> Bool {
        Cheker.shared.checkUser(inputLogin, inputPassword)
    }
}
