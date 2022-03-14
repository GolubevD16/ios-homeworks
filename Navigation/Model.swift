//
//  Model.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 14.03.2022.
//

import Foundation

class Model{
    var password: String = "password"
    
    func check(word: String) {
        NotificationCenter.default.post(name: .checkPassword, object: password.lowercased() == word.lowercased())
    }
}

extension Notification.Name {
    static let checkPassword = Notification.Name("checkPassword")
}
