//
//  LoginInspectorTest.swift
//  NavigationTests
//
//  Created by Дмитрий Голубев on 04.09.2022.
//

import Foundation
import XCTest
@testable import Navigation

class LoginInspectorTest: XCTestCase {
    var loginInspector: LogInInspector?
    var vc: MockLoginViewController!
    
    override func setUp() {
        super.setUp()
        
        vc = MockLoginViewController()
        loginInspector = LogInInspector(vc: vc)
    }
    
    func testCheckLoginPasswordGood() {
        let expectation = expectation(description: "competion should be completed")
        loginInspector?.checkLoginPasswordAvailability(inputLogin: "test@gmail.com", inputPassword: "testtest") { [unowned self] in
            expectation.fulfill()
            XCTAssertTrue(vc.isLogin)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckLoginNotAllField() {
        let expectation = expectation(description: "competion should be completed")
        loginInspector?.checkLoginPasswordAvailability(inputLogin: "", inputPassword: "12345678") {
            expectation.fulfill()
        }
        XCTAssertTrue(vc.isNotAllField)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckLoginRegistr() {
        let expectation = expectation(description: "competion should be completed")
        let email = String.randomString(length: 8) + "@gmail.com"
        loginInspector?.checkLoginPasswordAvailability(inputLogin: email, inputPassword: "testtest") { [unowned self] in
            expectation.fulfill()
            XCTAssertTrue(vc.isRegistr)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckLoginBadEmail() {
        let expectation = expectation(description: "competion should be completed")
        let email = String.randomString(length: 8)
        loginInspector?.checkLoginPasswordAvailability(inputLogin: email, inputPassword: "testtest") { [unowned self] in
            expectation.fulfill()
            XCTAssertTrue(vc.isBadEmail)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckLoginPassFail() {
        let expectation = expectation(description: "competion should be completed")
        loginInspector?.checkLoginPasswordAvailability(inputLogin: "test@gmail.com", inputPassword: "84851498584") { [unowned self] in
            expectation.fulfill()
            XCTAssertTrue(vc.isPassFail)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCheckLoginWeakPass() {
        let expectation = expectation(description: "competion should be completed")
        loginInspector?.checkLoginPasswordAvailability(inputLogin: "test@gmail.com", inputPassword: "123") { [unowned self] in
            expectation.fulfill()
            XCTAssertTrue(vc.isWeakPass)
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}

final class MockLoginViewController: LogInViewControllerDelegate {
    var isRegistr = false
    var isNotAllField = false
    var isBadEmail = false
    var isPassFail = false
    var isLogin = false
    var isWeakPass = false
    
    func tappedButton(sender: UIButton, name: String) {
        
    }
    
    func registr() {
        isRegistr = true
    }
    
    func notAllField() {
        isNotAllField = true
    }
    
    func badEmail() {
        isBadEmail = true
    }
    
    func passFail() {
        isPassFail = true
    }
    
    func login() {
        isLogin = true
    }
    
    func weakPass() {
        isWeakPass = true
    }
}
