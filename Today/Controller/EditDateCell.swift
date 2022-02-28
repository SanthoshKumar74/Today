//
//  EditDateCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditDateCell:UITableViewCell{
    
    @IBOutlet var datePicker: UIDatePicker!
    
    func configure(date:Date){
        datePicker.date = date
    }
}
