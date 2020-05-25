//
//  SelectorViewController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class SelectorViewController: UIViewController {

    // Forced dependency injection:
    var launchDatabasesStructure: LaunchDatabasesStructure! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(launchDatabasesStructure)
    }

    func dependencyInjection(_ launchDatabasesStructure: LaunchDatabasesStructure) {
        self.launchDatabasesStructure = launchDatabasesStructure
    }

    private func configureUI(_ launchDatabasesStructure: LaunchDatabasesStructure) {
        buttonGoToMemoryDatabase    .isEnabled = launchDatabasesStructure.memory
        buttonGoToDefaultDatabase   .isEnabled = launchDatabasesStructure.userDefault
        buttonGoToRealmDatabase     .isEnabled = launchDatabasesStructure.realm
        buttonGoToCoreDataDatabase  .isEnabled = launchDatabasesStructure.coreData
    }

    @IBOutlet weak var buttonGoToMemoryDatabase: UIButton!
    @IBOutlet weak var buttonGoToDefaultDatabase: UIButton!
    @IBOutlet weak var buttonGoToRealmDatabase: UIButton!
    @IBOutlet weak var buttonGoToCoreDataDatabase: UIButton!

    @IBAction func onButton(_ sender: UIButton) {
        let segueIdentifier: String

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
        case "idSegueToMemory":
            if let tableViewController = segue.destination as? TableViewController {
                tableViewController.dependencyInjection(.memory)
            }
        case "idSegueToUserDefault":
            if let tableViewController = segue.destination as? TableViewController {
                tableViewController.dependencyInjection(.userDefault)
            }
        case "idSegueToRealm":
            if let tableViewController = segue.destination as? TableViewController {
                tableViewController.dependencyInjection(.realm)
            }
        case "idSegueToCoreData":
            if let tableViewController = segue.destination as? TableViewController {
                tableViewController.dependencyInjection(.coreData)
            }
        default:
            break
        }
    }

}
