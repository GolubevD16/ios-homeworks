//
//  UserService.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.02.2022.
//

import Foundation

protocol UserService{
    func getUser(name: String) -> User?
}

class CurrentUserService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }

    func getUser(name: String) -> User? {
        guard user.fullName == name else { return nil }
        return user
    }
}


class TestUserService: UserService{
    var user = User(fullName: "Dima", avatar: "dragon", status: "hello")
    func getUser(name: String) -> User? {
        return user
    }
}
