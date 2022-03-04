//
//  ReminderDetailViewDataSource.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit
import CoreData

class ReminderDetailViewDataSource: NSObject
{
    
    static let reminderDetailCellIdentifier = "ReminderDetailCell"
    
    enum ReminderRow:Int, CaseIterable{
        case title
        case date
        case notes
        case time
        
        static let dateFormatter : DateFormatter =
        {
            let formatter = DateFormatter()
            formatter.timeStyle = .none
            formatter.dateStyle = .long
            return formatter
        }()
    
        
        static let timeFormatter : DateFormatter =
        
        {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            formatter.dateStyle = .none
            return formatter
        }()
    
    func displayText(for reminder:Reminderlist?)-> String?
    {
        switch self
        {
        case .title:
            return reminder?.title
        case .date:
            guard let date = reminder?.date else { return nil }
            if Locale.current.calendar.isDateInToday(date) {
                return NSLocalizedString("Today", comment: "Today for date description")
            }
            return Self.dateFormatter.string(from: date)
        case .time:
            guard let time = reminder?.date else{return nil}
            return Self.timeFormatter.string(from: time)
        case .notes:
            return reminder?.notes
            
        }
    }
    
        
        var cellImage: UIImage? {
                    switch self {
                    case .title:
                        return nil
                    case .date:
                        return UIImage(systemName: "calendar.circle")
                    case .time:
                        return UIImage(systemName: "clock")
                    case .notes:
                        return UIImage(systemName: "square.and.pencil")
                    }
        }
        
    }
    private var reminder: Reminderlist

        init(reminder: Reminderlist) {
            self.reminder = reminder
            super.init()
        }

    
}


//MARK: - DataSource Methods
extension ReminderDetailViewDataSource:UITableViewDataSource{

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
{
    return ReminderRow.allCases.count
}
    

 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
{
    let cell = tableView.dequeueReusableCell(withIdentifier: Self.reminderDetailCellIdentifier, for: indexPath)
    let row = ReminderRow(rawValue: indexPath.row)
    cell.imageView?.image = row?.cellImage
    cell.textLabel?.text = row?.displayText(for: reminder)
    return cell
}
}
