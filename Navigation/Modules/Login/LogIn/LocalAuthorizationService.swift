//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Дмитрий Голубев on 06.09.2022.
//

import Foundation
import LocalAuthentication

final class LocalAuthorizationService {
    private let context = LAContext()
    private let policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics
    private var error: NSError?
    private var canUseBiometric = false
    
    init() {
        canUseBiometric = context.canEvaluatePolicy(policy, error: &error)
    }
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Void, Error>) -> Void) {
        if let error = error {
            authorizationFinished(.failure(error))
        }
        if !canUseBiometric{
            authorizationFinished(.failure(NSError()))
        }
        
        context.evaluatePolicy(policy,
                               localizedReason: "Авторизируйтесь для входа")
        { success, error in
            if let error = error {
                authorizationFinished(.failure(error))
            }
            if success {
                authorizationFinished(.success(()))
            }
        }
    }
}
