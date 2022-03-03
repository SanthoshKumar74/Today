//
//  ReminderListDataSource.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class ReminderListDataSource: NSObject{
    private lazy var timeFormatter = RelativeDateTimeFormatter()
    
    enum Filter:Int{
        case today
        case future
        case all
        
        
        func shouldInclude(date: Date) -> Bool {
            let isInToday = Locale.current.calendar.isDateInToday(date)
            switch self {
            case .today:
                return isInToday
            case .future:
                return (date > Date()) && !isInToday
            case .all:
                return true
            }
        }
    }
    
    var filter:Filter = .today

    var filteredReminders: [Reminder]
    {
        return Reminder.testData.filter { filter.shouldInclude(date: $0.date) }.sorted { $0.date < $1.date }
    }
    
    func update(_ reminder: Reminder, at row: Int)
    {
        let index = self.index(for: row)
                Reminder.testData[index] = reminder
    }
    
    func reminder(at row: Int) -> Reminder {

        return filteredReminders[row]
    }
    //To-Add-Remainder
    func add(_ reminder: Reminder)-> Int? {
        Reminder.testData.insert(reminder, at: 0)
        return filteredReminders.firstIndex(where: { $0.id == reminder.id })
    }
    //Filter
    func index(for filteredIndex: Int) -> Int {
            let filteredReminder = filteredReminders[filteredIndex]
            guard let index = Reminder.testData.firstIndex(where: { $0.id == filteredReminder.id }) else {
                fatalError("Couldn't retrieve index in source array")
            }
            return index
        }
}

extension ReminderListDataSource:UITableViewDataSource{
    // MARK: - TableView DataSource Methods.
        
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return filteredReminders.count
        }
        
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "RemainderListCell", for: indexPath) as? RemainderListCell
            else
                
            {
                fatalError("Unable to deque cell")
            }
            
            
            let currentReminder =  reminder(at: indexPath.row)
            let action = {
                var modifiedReminder = currentReminder
                modifiedReminder.isComplete.toggle()
                self.update(modifiedReminder, at: indexPath.row)
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            let dateText = currentReminder.dueDateTimeText(for: filter)
            cell.configureAction(action: action,title: currentReminder.title,date: dateText,isComplete: currentReminder.isComplete)
            
            return cell
        }
    
    
//     func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//         tableView.beginUpdates()
//         Reminder.testData.remove(at: indexPath.row)
//         tableView.reloadData()
//         tableView.endUpdates()
//    }

    }

extension Reminder {

    static let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        return timeFormatter
    }()

    static let futureDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()

    static let todayDateFormatter: DateFormatter = {
         let format = NSLocalizedString("'Today at '%@", comment: "format string for dates occurring today")
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = String(format: format, "hh:mm a")
         return dateFormatter
     }()
    
    func dueDateTimeText(for filter: ReminderListDataSource.Filter) -> String {
        let isInToday = Locale.current.calendar.isDateInToday(date)
        switch filter {
        case .today:
            return Self.timeFormatter.string(from: date)
        case .future:
            return Self.futureDateFormatter.string(from: date)
        case .all:
            if isInToday {
                return Self.todayDateFormatter.string(from: date)
            } else {
                return Self.futureDateFormatter.string(from: date)
            }
        }
    }
}

