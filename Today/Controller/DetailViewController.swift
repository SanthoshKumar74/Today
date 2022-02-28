//
//  DetailViewController.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class DetailViewController:UITableViewController{
  
    private var reminder:Reminder?
    private var dataSource:UITableViewDataSource?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        setEditing(false, animated: false)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    func configure(reminder:Reminder){
        self.reminder = reminder
    }
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        guard let reminder = reminder else {
            fatalError("No Reminder found for Detail View")}
        if editing
        {
            dataSource = ReminderDetailEditDataSource(reminder: reminder)
        }
        else
        {
            dataSource = ReminderDetailViewDataSource(reminder: reminder)
        }

        
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}


