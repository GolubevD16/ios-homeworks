//
//  StatusModelTest.swift
//  NavigationTests
//
//  Created by Дмитрий Голубев on 04.09.2022.
//

import XCTest
@testable import Navigation

class StatusManagerTest: XCTestCase {
    var statusManager: StatusManager!

    override func setUp() {
        super.setUp()
        statusManager = StatusManager()
    }
    
    func checkReultResidents() {
        XCTAssertTrue(!statusManager.residents.isEmpty)
    }
}
