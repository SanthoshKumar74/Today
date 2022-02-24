//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class ReminderListDataSource: NSObject{
    private lazy var timeFormatter = RelativeDateTimeFormatter()
    
}

extension ReminderListDataSource:UITableViewDataSource{
    // MARK: - TableView DataSource Methods.
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Reminder.testData.count
        }
        
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "RemainderListCell", for: indexPath) as? RemainderListCell
            else
            {
                fatalError("Unable to deque cell")
            }
            
    //Change the TableView Cell Labels and buttons with appropriate data.
            
            let reminder =  Reminder.testData[indexPath.row]
            let action = {
                Reminder.testData[indexPath.row].isComplete.toggle()
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            let dateText = timeFormatter.localizedString(for: reminder.date, relativeTo: Date())
            cell.configureAction(action: action,title: reminder.title,date: dateText,isComplete: reminder.isComplete)
            return cell
        }
    }


