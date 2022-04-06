//
//  User.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.02.2022.
//

import Foundation

class User {
    var fullName: String
    var avatar: String
    var status: String
    
    init(fullName: String, avatar: String, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
