//
//  Cheker.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 22.02.2022.
//

import Foundation

final class Cheker{
    static let shared = Cheker()
    private let login = "Dima"
    private let pswd = "123"
    
    private init() {}
    
    func checkUser(_ log: String, _ password: String) -> Bool{
        return login.hash == log.hash && pswd.hash == password.hash
    }
}