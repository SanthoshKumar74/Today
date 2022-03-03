//
//  EditTitleCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditTitleCell:UITableViewCell{
    @IBOutlet var titleTextField: UITextField!
    
    typealias TitleEditAction = (String) -> Void
    
    private  var titleEditAction:TitleEditAction?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleTextField.delegate = self
    }
    
    func configure(title:String,editAction:TitleEditAction?)
    {
        titleTextField.text = title
        self.titleEditAction = editAction
    }
    
  
    
   
}

extension EditTitleCell:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let originalText = textField.text
        {
            let title = (originalText as NSString).replacingCharacters(in: range, with: string)
            titleEditAction?(title)
        }
        return true
    }
}
