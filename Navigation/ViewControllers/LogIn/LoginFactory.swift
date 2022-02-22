//
//  LoginFactory.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.02.2022.
//

import Foundation

protocol LoginFactory{
    func makeInspector() -> LogInInspector
}
