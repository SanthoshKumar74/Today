//
//  DetailViewController.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit
import CoreData

class DetailViewController:UITableViewController{
    
    
    typealias ReminderChangeAction = (Reminderlist)-> Void
    private var reminder:Reminderlist?
    private var tempReminder:Reminderlist?
    private var dataSource:UITableViewDataSource?
    private var reminderEditAction:ReminderChangeAction?
    private var reminderAddAction:ReminderChangeAction?
    private var isNew = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setEditing(isNew, animated: false)
        
        navigationItem.setRightBarButton(editButtonItem, animated: false)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ReminderDetailEditDataSource.dateLabelCellIdentifier)
    }
    func configure(reminder:Reminderlist, isNew:Bool=false, addAction:ReminderChangeAction?=nil,editAction:ReminderChangeAction?=nil){
        print("NewItem")
        self.reminder = reminder
        self.isNew = isNew
        self.reminderAddAction = addAction
        self.reminderEditAction = editAction
        if isViewLoaded{
            setEditing(isNew, animated: false)
        }
    }
    
    fileprivate func transitionToViewModel(_ reminder:Reminderlist)
    {
        if isNew {
            let addReminder = tempReminder ?? reminder
            dismiss(animated: true) {
                self.reminderAddAction?(addReminder)
                
            }
            return
        }
        
        if let tempReminder = tempReminder {
            self.reminder = tempReminder
            self.tempReminder = nil
            reminderEditAction?(tempReminder)
            dataSource = ReminderDetailViewDataSource(reminder: tempReminder)
        } else {
            dataSource = ReminderDetailViewDataSource(reminder: reminder)
        }
        navigationItem.title = NSLocalizedString("View Reminder", comment: "view reminder nav title")
        navigationItem.leftBarButtonItem = nil
        editButtonItem.isEnabled = true
    }
        
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController, !navigationController.isToolbarHidden
        {
            navigationController.setToolbarHidden(true, animated: false)
        }
    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        guard let reminder = reminder else {
            fatalError("No reminder found for detail view")
        }
        if editing {
            dataSource = ReminderDetailEditDataSource(reminder: reminder) { reminder in
                self.tempReminder = reminder
                self.editButtonItem.isEnabled = true
            }
            navigationItem.title = isNew ? NSLocalizedString("Add Reminder", comment: "add reminder nav title") :
            NSLocalizedString("Edit Reminder", comment: "edit reminder nav title")
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTrigger))
        } else {
            transitionToViewModel(reminder)
        }
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    @objc func cancelButtonTrigger() {
        
        if isNew {
            dismiss(animated: true, completion: nil)
        } else {
            tempReminder = nil
            setEditing(false, animated: true)
        }
    }
    

}


