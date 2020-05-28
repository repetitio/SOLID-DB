//
//  TableViewController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet var buttonPlus: [UINavigationItem]!

    @IBAction func onButtonPlus(_ sender: UIBarButtonItem) {
        addNewRecord()
    }

    var launchParameter: LaunchDatabaseParameter! = nil
    var databaseService: DatabaseCRUDProtocol! = nil

    func dependencyInjection(_ launchParameter: LaunchDatabaseParameter) {
        self.launchParameter = launchParameter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        title = launchParameter.rawValue
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    private func addNewRecord() {
        print("✏️ Add New Record...")
    }

}
