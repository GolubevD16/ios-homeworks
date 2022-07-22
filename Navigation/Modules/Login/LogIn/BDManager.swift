//
//  BDManager.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 25.06.2022.
//

import Foundation
import RealmSwift

@objcMembers class UserDB: Object{
    dynamic var email: String?
    dynamic var password: String?
    dynamic var isAuth = false
    
    override static func primaryKey() -> String{
        return "email"
    }
}

final class DataProvider{
    
    static func addUser(email: String, pas: String){
        let user = UserDB(value: ["email": email, "password": pas, "isAuth": true])
        do {
            let realm = try? Realm()
            
            realm?.beginWrite()
            realm?.add(user)
            try realm?.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func checkAuth() -> Bool{
        let realm = try? Realm()
        guard let results = realm?.objects(UserDB.self) else {
            return false
        }
        if results.isEmpty { return false }
        return results[0].isAuth
    }
}
