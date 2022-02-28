//
//  EditNotesCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditNotesCell: UITableViewCell{
    
    @IBOutlet var notesTextView: UITextView!
    
    func configure(notes:String?){
        notesTextView.text = notes
    }
}
