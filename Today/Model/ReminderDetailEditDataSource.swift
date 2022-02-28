//
//  ReminderDetailEditDataSource.swift
//  Today
//
//  Created by Santhosh on 25/02/22.
//

import UIKit

class ReminderDetailEditDataSource:NSObject{
    enum ReminderSection:Int, CaseIterable{
        case title
        case date
        case notes
        
        
        var displayText:String{
            switch self {
            case .title:
                return "Title"
            case .date:
                return "Date"
            case .notes:
                return "Notes"
            }
        }
        
        var numRows:Int{
            switch self {
            case .title,.notes:
                return 1
            case .date:
                return 2
        
            }
        }
        
        func cellIdentifier(for row: Int) -> String {
                    switch self {
                    case .title:
                        return "EditTitleCell"
                    case .date:
                        return row == 0 ? "EditDateLabelCell" : "EditDateCell"
                    case .notes:
                        return "EditNotesCell"
            }
        }
    }
    
    static var dateLabelCellIdentifier: String {
          return ReminderSection.date.cellIdentifier(for: 0)
      }

    var reminder:Reminder
    
    init(reminder:Reminder){
        self.reminder = reminder
    }
    
    func dequeAndConfigureCell(for indexPath:IndexPath,from tableView:UITableView)-> UITableViewCell{
        guard let section = ReminderSection(rawValue: indexPath.section)
        else{
            fatalError("Section Out of Range")
        }
        
        let identifier = section.cellIdentifier(for: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        switch section {
        case .title:
            if let titleCell = cell as? EditTitleCell {
                titleCell.configure(title: reminder.title)
            }
        case .date:
                    if indexPath.row == 0{
                        cell.textLabel?.text = reminder.date.description
                        
                    }
                  else
                {
                    if let dateCell = cell as? EditDateCell
                    {
                        dateCell.configure(date: reminder.date)
                    }
                }
            
        case .notes:
            if let notesCell = cell as? EditNotesCell
            {
                notesCell.configure(notes: reminder.notes)
            }
        }
        return cell
    }
}

//:MARK: - DataSource  methods

extension ReminderDetailEditDataSource:UITableViewDataSource{
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return dequeAndConfigureCell(for: indexPath, from: tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ReminderSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return ReminderSection(rawValue: section)?.numRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ReminderSection(rawValue: section) else
        {
            fatalError("Section Index out of range")
        }
        return section.displayText
    }
}

