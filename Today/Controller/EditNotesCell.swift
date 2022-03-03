//
//  EditNotesCell.swift
//  Today
//
//  Created by Santhosh on 24/02/22.
//

import UIKit

class EditNotesCell: UITableViewCell{
    typealias EditNotesAction = (String)-> Void
    
    private var editNotesAction:EditNotesAction?
    
    @IBOutlet var notesTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notesTextView.delegate = self
        
    }
    
    func configure(notes:String?, editNotesAction:EditNotesAction?)
    {
        notesTextView.text = notes
        self.editNotesAction = editNotesAction
    }
}

extension EditNotesCell:UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let originalText = textView.text {
            let title = (originalText as NSString).replacingCharacters(in: range, with: text)
            editNotesAction?(title)
        }
        return true
    }
}

