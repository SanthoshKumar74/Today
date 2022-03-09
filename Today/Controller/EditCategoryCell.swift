//
//  EditCategoryCell.swift
//  Today
//
//  Created by Santhosh on 09/03/22.
//

import UIKit
import CoreData

class EditCategoryCell: UITableViewCell {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   
    typealias CategoryEditAction = (Category)-> Void
    
    private var categoryEditAction:CategoryEditAction?
    
    private var categories:[Category]?
    
    private var categoryName:String?
    
    @IBOutlet var categoryPicker: UIPickerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        categories = try! context.fetch(fetchRequest) as! [Category]
        
    }

    func configure(category:String,categoryEditAction:CategoryEditAction?)
    {
        self.categoryName = category
        self.categoryEditAction = categoryEditAction
        
    }

}

extension EditCategoryCell:UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories![row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryEditAction!(categories![row])
    }
    
}
