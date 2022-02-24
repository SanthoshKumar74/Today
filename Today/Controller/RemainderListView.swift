//
//  ViewController.swift
//  Today
//
//  Created by Santhosh on 23/02/22.
//

import UIKit

class RemainderListView: UITableViewController {
    private var reminderDataSource:ReminderListDataSource?
    
    static let showDetailViewSegue = "ShowDetailViewSegue"
   
 
    

//MARK: - Configuring the detail view cell with appropriate values


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Self.showDetailViewSegue,
           let destination = segue.destination as? DetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell)
        {
            let reminder = Reminder.testData[indexPath.row]
            destination.configure(reminder: reminder)
        }
    }
    
}
//MARK: - Initialising the datasourse
extension RemainderListView{
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderDataSource = ReminderListDataSource()
        tableView.dataSource = reminderDataSource
    }
}
