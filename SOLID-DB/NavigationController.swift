//
//  NavigationController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "idSegueToMain", sender: self)
    }
    
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // App configuration, main dependency injection
        switch segue.identifier {
        case "idSegueToMain":
            if let selectorVC = segue.destination as? DatabaseSelectorViewController {
                selectorVC.isEnabledMemory          = false
                selectorVC.isEnabledUserDefault     = false
                selectorVC.isEnabledRealm           = false
                selectorVC.isEnabledCoreData        = false
            }
        default:
            break
        }
    }
    
}
