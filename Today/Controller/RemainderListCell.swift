//
//  RemainderListCell.swift
//  Today
//
//  Created by Santhosh on 23/02/22.
//

import UIKit
import CoreData


//Table View Cell Actions and Outlets.
class RemainderListCell:UITableViewCell{
    
    typealias DoneButtonAction = ()->Void
    
    @IBOutlet var doneButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var dateLabel: UILabel!
    
   private  var doneButtonAction: DoneButtonAction?
    
    func configureAction(action:@escaping DoneButtonAction,title: String,date:String,isComplete:Bool){
        doneButtonAction = action
        titleLabel.text = title
        dateLabel.text = date
        let image = isComplete ? UIImage(systemName: "circle.fill") : UIImage(systemName: "circle")
        doneButton.setImage(image, for: .normal)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        doneButtonAction?()
        
    }
    
}


