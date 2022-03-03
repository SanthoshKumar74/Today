//
//  EditDateCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditDateCell:UITableViewCell{
    
    typealias EditDateAction = (Date)-> Void
    
    @IBOutlet var datePicker: UIDatePicker!
    
    private var editDateAction:EditDateAction?
    
    func configure(date:Date,editDateAction:EditDateAction?){
        self.editDateAction = editDateAction
        datePicker.date = date
    }
    
    @objc func dateEdited(_ sender:UIDatePicker){
        editDateAction?(sender.date)
        
    }
    override  func awakeFromNib() {
        super .awakeFromNib()
        datePicker.addTarget(self, action: #selector(dateEdited(_:)), for: .valueChanged)
    }
}
