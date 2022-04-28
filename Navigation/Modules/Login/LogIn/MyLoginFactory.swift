//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 23.02.2022.
//

import Foundation

class MyLoginFactory: LoginFactory{
    let delegate: LogInViewControllerDelegate
    
    init(vc: LogInViewControllerDelegate){
        self.delegate = vc
    }
    
    func makeInspector() -> LogInInspector {
        return LogInInspector(vc: delegate)
    }
}
