//
//  NavigationController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    var launchDatabasesStructure :LaunchDatabasesStructure! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureWithLaunchOptionsDatabases(_ launchDatabasesStructure:LaunchDatabasesStructure) {
        self.launchDatabasesStructure = launchDatabasesStructure
        performSegue(withIdentifier: "idSegueToSelectorVC", sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // App configuration, main dependency injection
        switch segue.identifier {
        case "idSegueToSelectorVC":
            if let selectorViewController = segue.destination as? SelectorViewController {
                selectorViewController.dependencyInjection(launchDatabasesStructure)
            }
        default:
            break
        }
    }
    
}
