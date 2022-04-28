//
//  NetworkManager.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 17.04.2022.
//

import Foundation

struct NetworkManager {
    /// ошибка при отключенном интернете: The Internet connection appears to be offline.
    
    static func startURLSessionWithStringUrl(with url: String){
        guard let url = URL(string: url) else {print("Can't create URL"); return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                guard let error = error else {return}
                print(error.localizedDescription)
                return
            }
//            guard let response = response as? HTTPURLResponse else {return}
//            guard let data = data else {return}
//            guard let encodedData = String(data: data, encoding: .utf8) else {return}
            //print(encodedData, "\n\n", response.allHeaderFields, "\n\n", response.statusCode)
        }
        
        task.resume()
        
    }
}

enum AppConfiguration: String{
    case people = "https://swapi.dev/api/people/8"
    case starship = "https://swapi.dev/api/starships/3"
    case planet = "https://swapi.dev/api/planets/5"
    
    public static var allCases: [AppConfiguration]{
        return [.people, .starship, .planet]
    }
}

enum AppConfiguration1{
    typealias RawValue = URL

    case people(URL)
    case starship(URL)
    case planet(URL)
    
    public static var allCases: [AppConfiguration]{
        return [.people, .starship, .planet]
    }
}
