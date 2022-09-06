//
//  StatusModel.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 21.04.2022.
//

import Foundation

struct PeopleModel{
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

struct PlanetModel: Decodable{
    let planetName: String
    let orbitalPeriod: String
    let residents: [String]
    
    enum CodingKeys: String, CodingKey{
        case planetName = "name"
        case orbitalPeriod = "orbital_period"
        case residents = "residents"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        planetName = try container.decode(String.self, forKey: .planetName)
        orbitalPeriod = try container.decode(String.self, forKey: .orbitalPeriod)
        residents = try container.decode([String].self, forKey: .residents)
    }
}


struct ResidentModel: Decodable{
    let name: String
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
    }
}

protocol StatusModelProtocol {
    func setTitlePeople(_ completion: @escaping () -> Void)
}

final class StatusManager: StatusModelProtocol {
    var status: StatusView?
    var residentsURL = [URL]()
    var residents = [ResidentModel]()
    
    func setTitlePeople(_ completion: @escaping () -> Void){
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/16"){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrapedData = data{
                    do{
                        let serializedDict = try JSONSerialization.jsonObject(with: unwrapedData, options: [])
                        if let dict = serializedDict as? [String: Any]{
                            let userId: Int = dict["userId"] as! Int
                            let id: Int = dict["id"] as! Int
                            let title: String = dict["title"] as! String
                            let completed: Bool = dict["completed"] as! Bool
                            let people = PeopleModel(userId: userId, id: id, title: title, completed: completed)
                            completion()
                            self.showTitlePeople(people)
                        }
                        
                    }
                    catch let error{
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func setTitlePlanet(){
        if let url = URL(string: "https://swapi.dev/api/planets/1"){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrapedData = data{
                    do {
                        let planet = try JSONDecoder().decode(PlanetModel.self, from: unwrapedData)
                        self.showTitlePlanet(planet)
                        self.residentsURL = planet.residents.compactMap() {
                            URL(string: $0)
                            
                        }
                        self.getAllResidents()
                    }
                    catch let error{
                        print(error)
                    }
                        
                }
                
            }
            task.resume()
        }
    }
    
    func getAllResidents(){
        
        for residentURL in residentsURL{
            addResident(for: residentURL)
        }
    }
    
    func addResident(for residentURL: URL){
        let task = URLSession.shared.dataTask(with: residentURL) { data, response, error in
            if let unwrapedData = data{
                do {
                    let resident = try JSONDecoder().decode(ResidentModel.self, from: unwrapedData)
                    self.residents.append(resident)
                    self.status?.residents = self.residents
                    NotificationCenter.default.post(name: .addResident, object: nil)
                }
                catch let error{
                    print(error)
                }
                    
            }
            
        }
        task.resume()
    }
    
    func showTitlePeople(_ people: PeopleModel){
        DispatchQueue.main.async {
            self.status?.label.text = people.title
        }
    }
    
    func showTitlePlanet(_ planet: PlanetModel){
        let title = "orbital period of " + planet.planetName + " = " + planet.orbitalPeriod
        DispatchQueue.main.async {
            self.status?.label2.text = title
        }
    }
}

extension Notification.Name {
    static let addResident = Notification.Name("addResident")
}
