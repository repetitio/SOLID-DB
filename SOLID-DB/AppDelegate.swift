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
        
        let arguments = ProcessInfo.processInfo.arguments
        for argument in arguments {
            print("💋argument='\(argument)'")
            switch argument {
            case "-TESTS_UI":
                UIView.setAnimationsEnabled(false)
            default:break
            }
        }
        
        return true
    }
    
}

