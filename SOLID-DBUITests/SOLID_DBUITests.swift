//
//  SOLID_DBUITests.swift
//  SOLID-DBUITests
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import XCTest

class SOLID_DBUITests: XCTestCase {

    fileprivate func setupAppArguments(_ app: XCUIApplication) {
        app.launchArguments.append("-memory")
        app.launchArguments.append("-userDefault")
        app.launchArguments.append("-realm")
        app.launchArguments.append("-coreData")
        app.launchArguments.append("-TESTS_UI")
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchAllDatabases() throws {
        let app = XCUIApplication()
        setupAppArguments(app)
        app.launch()

        print("👉=processInfo.arguments='\(ProcessInfo.processInfo.arguments)'")
        print("👉app.launchEnvironment='\(app.launchEnvironment)'")
        print("👉app.launchArguments) ='\(app.launchArguments)'")

        XCTAssert(app.launchArguments.contains("-memory"))
        XCTAssert(app.launchArguments.contains("-userDefault"))
        XCTAssert(app.launchArguments.contains("-realm"))
        XCTAssert(app.launchArguments.contains("-coreData"))

        XCTAssert(app.buttons["idSelectorButtonMemory"].isEnabled)
        XCTAssert(app.buttons["idSelectorButtonUserDefault"].isEnabled)
        XCTAssert(app.buttons["idSelectorButtonRealm"].isEnabled)
        XCTAssert(app.buttons["idSelectorButtonCoreData"].isEnabled)
    }

    func testLaunchNoneDatabases() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssert(!app.launchArguments.contains("-memory"))
        XCTAssert(!app.launchArguments.contains("-userDefault"))
        XCTAssert(!app.launchArguments.contains("-realm"))
        XCTAssert(!app.launchArguments.contains("-coreData"))

        XCTAssert(!app.buttons["idSelectorButtonMemory"].isEnabled)
        XCTAssert(!app.buttons["idSelectorButtonUserDefault"].isEnabled)
        XCTAssert(!app.buttons["idSelectorButtonRealm"].isEnabled)
        XCTAssert(!app.buttons["idSelectorButtonCoreData"].isEnabled)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                let app = XCUIApplication()
                app.launch()
            }
        }
    }

    func testLaunchPerformanceOmmitANimation() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                let app = XCUIApplication()
                setupAppArguments(app)
                app.launch()
            }
        }
    }

}
