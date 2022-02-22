//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.02.2022.
//

import Foundation

class MyLoginFactory: LoginFactory{
    func makeInspector() -> LogInInspector {
        return LogInInspector()
    }
}
