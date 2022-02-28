//
//  EditTitleCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditTitleCell:UITableViewCell{
    @IBOutlet var titleTextField: UITextField!
    
    func configure(title:String){
        titleTextField.text = title
    }
}
