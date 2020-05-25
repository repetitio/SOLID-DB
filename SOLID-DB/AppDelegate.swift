//
//  AppDelegate.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("💋💋='\(String(describing: launchOptions))'")

        var launchOptionsDatabases = (memory:false,
                                      userDefault:false,
                                      realm:false,
                                      coreData:false)

        let arguments = ProcessInfo.processInfo.arguments
        for argument in arguments {
            print("💋argument='\(argument)'")
            switch argument {
            case "-TESTS_UI":
                UIView.setAnimationsEnabled(false)
            case LaunchDatabaseParameter.memory.rawValue:
                launchOptionsDatabases.memory = true
            case LaunchDatabaseParameter.userDefault.rawValue:
                launchOptionsDatabases.userDefault = true
            case LaunchDatabaseParameter.realm.rawValue:
                launchOptionsDatabases.realm = true
            case LaunchDatabaseParameter.coreData.rawValue:
                launchOptionsDatabases.coreData = true
            default:break
            }
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let navigationController = storyboard.instantiateInitialViewController() as? NavigationController else {
            fatalError()
        }

        let launchDatabasesStructure = LaunchDatabasesStructure(memory: launchOptionsDatabases.memory,
                                                    userDefault: launchOptionsDatabases.userDefault,
                                                    realm: launchOptionsDatabases.realm,
                                                    coreData: launchOptionsDatabases.coreData)
        navigationController.configureWithLaunchOptionsDatabases(launchDatabasesStructure)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

}
