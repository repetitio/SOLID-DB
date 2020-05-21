//
//  DatabaseSelectorViewController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class DatabaseSelectorViewController: UIViewController {
    
    // Forced dependency injection:
    var isEnabledMemory         :Bool! = nil
    var isEnabledUserDefault    :Bool! = nil
    var isEnabledRealm          :Bool! = nil
    var isEnabledCoreData       :Bool! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        buttonGoToMemoryDatabase    .isEnabled = isEnabledMemory
        buttonGoToDefaultDatabase   .isEnabled = isEnabledUserDefault
        buttonGoToRealmDatabase     .isEnabled = isEnabledRealm
        buttonGoToCoreDataDatabase  .isEnabled = isEnabledCoreData
    }
    
    @IBOutlet weak var buttonGoToMemoryDatabase :UIButton!
    @IBOutlet weak var buttonGoToDefaultDatabase:UIButton!
    @IBOutlet weak var buttonGoToRealmDatabase  :UIButton!
    @IBOutlet weak var buttonGoToCoreDataDatabase:UIButton!
    
    
    @IBAction func onButton(_ sender: UIButton) {
        let segueIdentifier:String
        
        switch sender.tag {
        case 1:
            segueIdentifier = "idSegueToUserDefault"
        case 2:
            segueIdentifier = "idSegueToRealm"
        case 3:
            segueIdentifier = "idSegueToCoreData"
        case 4:
            segueIdentifier = "idSegueToMemory"
        default:
            fatalError("bad configuration")
        }
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    
    // Configure Database Controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "idSegueToUserDefault":
            if let dataTableViewController = segue.destination as? DataTableViewController {
                // bad, ctrl shouldn't know it                dataTableViewController.databaseType = .userDefaut
            }
            
        default:
            break
        }
    }
    
}
