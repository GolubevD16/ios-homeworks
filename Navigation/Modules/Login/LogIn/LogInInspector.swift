//
//  LogInInspector.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.02.2022.
//

import Foundation
import FirebaseAuth

final class LogInInspector: LogInViewControllerCheckerDelegate{
    weak var delegate: LogInViewControllerDelegate?
    
    init(vc: LogInViewControllerDelegate){
        self.delegate = vc
    }
    func checkLoginPasswordAvailability(inputLogin: String, inputPassword: String){
        if inputLogin.isEmpty || inputPassword.isEmpty{
            delegate?.notAllField()
        } else {
            Auth.auth().signIn(withEmail: inputLogin, password: inputPassword) { result, error in
                print(error?.localizedDescription ?? "not error")
                if error == nil{
                    self.delegate?.login()
                    DataProvider.addUser(email: inputLogin, pas: inputPassword)
                }
                if error?.localizedDescription == authError.badlyPassword.rawValue{
                    self.delegate?.badEmail()
                }
                if error?.localizedDescription == authError.cantLogin.rawValue || error?.localizedDescription == authError.userNoyFound.rawValue{
                    Auth.auth().createUser(withEmail: inputLogin, password: inputPassword) { result, error1 in
                        if error1 == nil{
                            self.delegate?.registr()
                            DataProvider.addUser(email: inputLogin, pas: inputPassword)
                        }
                        if error1?.localizedDescription == authError.weakPass.rawValue{
                            self.delegate?.weakPass()
                        }
                        if error1?.localizedDescription == authError.failPassword.rawValue{
                            self.delegate?.passFail()
                        }
                    }
                }
            }
            
        }
    }
}

enum authError: String{
    case badlyPassword = "The email address is badly formatted."
    case cantLogin = "The password is invalid or the user does not have a password."
    case failPassword = "The email address is already in use by another account."
    case userNoyFound = "There is no user record corresponding to this identifier. The user may have been deleted."
    case weakPass = "The password must be 6 characters long or more."
}
