//
//  DataTableViewController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

class DataTableViewController: UITableViewController {
    
    var databaseType:DatabaseType! = nil
    var databaseService: DatabaseCRUDProtocol! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI(databaseType)
    }
    
    private func configureUI(_ databaseType:DatabaseType) {
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}
