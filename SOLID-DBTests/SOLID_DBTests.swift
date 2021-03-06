//
//  SOLID_DBTests.swift
//  SOLID-DBTests
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import XCTest
import RealmSwift

@testable import SOLID_DB

class SOLID_DBTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataStructuresConversion() throws {

        let text = "Test text..."
        let uuid = UUID()
        let date = Date()

        let dataViewModel = DataViewModel(text: text, uuid: uuid, date: date)
        XCTAssert(dataViewModel.text == text)
        XCTAssert(dataViewModel.uuid == uuid)
        XCTAssert(dataViewModel.date == date)

        let dataMemoryModel = DataMemoryModel(dataViewModel: dataViewModel)
        XCTAssert(dataMemoryModel.text == text)

        let dataViewModelFromMemoryModel = DataViewModel(dataMemoryModel: dataMemoryModel)
        XCTAssert(dataViewModelFromMemoryModel.text == text)
        XCTAssert(dataViewModelFromMemoryModel.uuid != uuid)
        XCTAssert(dataViewModelFromMemoryModel.date != date)

        let dataUserDefaultModel = DataUserDefaultModel(dataViewModel: dataViewModel)
        XCTAssert(dataUserDefaultModel.text == text)
        XCTAssert(dataUserDefaultModel.uuid == uuid)
        XCTAssert(dataUserDefaultModel.date == date)

        let dataViewModelFromUserDefaultModel = DataViewModel(dataUserDefaultModel: dataUserDefaultModel)
        XCTAssert(dataViewModelFromUserDefaultModel.text == text)
        XCTAssert(dataViewModelFromUserDefaultModel.uuid == uuid)
        XCTAssert(dataViewModelFromUserDefaultModel.date == date)

        let dataRealmModel = DataRealmModel(text: text, uuid: uuid.uuidString, date: date)
        XCTAssert(dataRealmModel.text == text)
        XCTAssert(dataRealmModel.uuid == uuid.uuidString)
        XCTAssert(dataRealmModel.date == date)

        let dataViewModelFromRealmModel = DataViewModel(dataRealmModel: dataRealmModel)
        XCTAssert(dataViewModelFromRealmModel.text == text)
        XCTAssert(dataViewModelFromRealmModel.uuid == uuid)
        XCTAssert(dataViewModelFromRealmModel.date == date)
    }

    func testMemoryDatabase() throws {
        let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .memory)
        databaseMemory.removeAll()
        XCTAssert(databaseMemory.count() == 0)
        let text = "Memory text"
        let dataViewModel = DataViewModel(text: text)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        XCTAssert(databaseMemory.count() == 3)
        databaseMemory.removeAll()
        XCTAssert(databaseMemory.count() == 0)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.remove(dataViewModel: dataViewModel)
        XCTAssert(databaseMemory.count() == 0)
    }

    func testUserDefaultDatabase() throws {
        let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .userDefault)
        databaseMemory.removeAll()
        XCTAssert(databaseMemory.count() == 0)
        let text = "User Default text"
        let dataViewModel = DataViewModel(text: text)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.create(dataViewModel: dataViewModel)
        XCTAssert(databaseMemory.count() == 3)
        databaseMemory.removeAll()
        XCTAssert(databaseMemory.count() == 0)
        databaseMemory.create(dataViewModel: dataViewModel)
        databaseMemory.remove(dataViewModel: dataViewModel)
        XCTAssert(databaseMemory.count() == 0)
    }

    func testRealmDatabase() throws {
        let databaseRealm = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .realm)
        databaseRealm.removeAll()
        XCTAssert(databaseRealm.count() == 0)
        let text = "Realm text"
        databaseRealm.create(dataViewModel: DataViewModel(text: text))
        databaseRealm.create(dataViewModel: DataViewModel(text: text))
        databaseRealm.create(dataViewModel: DataViewModel(text: text))
        XCTAssert(databaseRealm.count() == 3)
        databaseRealm.removeAll()
        XCTAssert(databaseRealm.count() == 0)
        let dataViewModel = DataViewModel(text: text)
        databaseRealm.create(dataViewModel: dataViewModel)
        databaseRealm.remove(dataViewModel: dataViewModel)
        XCTAssert(databaseRealm.count() == 0)
    }

    func testPerformanceMemoryDatabase() throws {
        self.measure {
            let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .memory)
            databaseMemory.removeAll()

            let maxN = 10_000

            for index in 1...maxN {
                let text = "Record:'\(index)'"
                let dataViewModel = DataViewModel(text: text)
                databaseMemory.create(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseMemory.count() == maxN)

            for _ in 1...maxN {
                let dataViewModel: DataViewModel = databaseMemory.getElement(index: 0)
                databaseMemory.remove(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseMemory.count() == 0)
        }
    }

    func testPerformanceUserDefaultDatabase() throws {
        self.measure {
            let databaseMemory = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .userDefault)
            databaseMemory.removeAll()

            let maxN = 10

            for index in 1...maxN {
                let text = "Record:'\(index)'"
                let dataViewModel = DataViewModel(text: text)
                databaseMemory.create(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseMemory.count() == maxN)

            for _ in 1...maxN {
                let dataViewModel: DataViewModel = databaseMemory.getElement(index: 0)
                databaseMemory.remove(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseMemory.count() == 0)
        }
    }

    func testPerformanceRealmDatabase() throws {
        self.measure {
            let databaseRealm = DatabaseCreator.databaseCRUD(launchDatabaseParameter: .realm)
            databaseRealm.removeAll()
            XCTAssert(databaseRealm.count() == 0)

            let maxN = 1000

            for index in 1...maxN {
                let text = "Realm Record:'\(index)'"
                let dataViewModel = DataViewModel(text: text)
                databaseRealm.create(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseRealm.count() == maxN)

            for _ in 1...maxN {
                let dataViewModel: DataViewModel = databaseRealm.getElement(index: 0)
                databaseRealm.remove(dataViewModel: dataViewModel)
            }
            XCTAssert(databaseRealm.count() == 0)
        }
    }

}
