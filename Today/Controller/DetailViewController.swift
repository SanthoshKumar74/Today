//
//  DetailViewController.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class DetailViewController:UITableViewController{
  
    private var reminder:Reminder?
    private var reminderDetailViewDataSource:ReminderDetailViewDataSource?
    override func viewDidLoad() {
        guard let reminder = reminder else {
            fatalError("No Reminder found for Detail View")
        }

        reminderDetailViewDataSource = ReminderDetailViewDataSource(reminder: reminder)
        tableView.dataSource = reminderDetailViewDataSource
    }
    func configure(reminder:Reminder){
        self.reminder = reminder
    }
}


