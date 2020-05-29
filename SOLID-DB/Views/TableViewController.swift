//
//  TableViewController.swift
//  SOLID-DB
//
//  Created by admin on 5/21/20.
//  Copyright © 2020 PL. All rights reserved.
//

import UIKit

protocol DatabaseTableviewProtocol: class {
    func refresh()
}

class TableViewController: UITableViewController, DatabaseTableviewProtocol {

    var databaseService: DatabaseServiceCRUDProtocol! = nil

    @IBOutlet var buttonPlus: [UINavigationItem]!
    @IBAction func onButtonPlus(_ sender: UIBarButtonItem) {
        addNewRecord()
    }

    func configureTableView(databaseService: DatabaseServiceCRUDProtocol) {
        self.databaseService = databaseService
        databaseService.addDelegate(self)
        title = databaseService.title()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        configureUI()
    }

//    private func configureUI() {
//        title = tableTitle
//    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return databaseService.count()
    }

    private func addNewRecord() {
        print("✏️ Add New Record...")
        let dataViewModel = DataViewModel(text: "✏️ Add New Record...")
        databaseService.create(dataViewModel: dataViewModel)
    }

    func refresh() {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)

        let element = databaseService.getElement(index: indexPath.row)
        cell.textLabel?.text = element.text
        cell.detailTextLabel?.text = element.uuid.description

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
