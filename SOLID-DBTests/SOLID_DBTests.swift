//
//  SOLID_DBTests.swift
//  SOLID-DBTests
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import XCTest
@testable import SOLID_DB

class SOLID_DBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMemoryDatabase() throws {

        let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .memory)
        XCTAssert(databaseMemory.count() == 0)
        let text = "Some text"
        let dataViewModel = DataViewModel(text: text)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        XCTAssert(databaseMemory.count() == 3)
        databaseMemory.removeAll()
        XCTAssert(databaseMemory.count() == 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .memory)
            let maxN = 1000000
            for index in 1...maxN {
                let text = "Record:'\(index)'"
                let dataViewModel = DataViewModel(text: text)
                databaseMemory.create(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseMemory.count() == maxN)

        }
    }

}
