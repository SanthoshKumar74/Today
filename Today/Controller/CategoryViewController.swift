//
//  CategoryViewController.swift
//  Today
//
//  Created by Santhosh on 08/03/22.
//

import UIKit

class CategoryViewController:UITableViewController{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categories:[Category]  = []
    

  
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
    
    var textField = UITextField()
        let category = Category(context: context)
        let alert = UIAlertController(title: "Add a Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add a Category", style: .default) { action in
            category.name = textField.text!
            self.categories.append(category)
            try! self.context.save()
            self.tableView.reloadData()
        
        }
        alert.addAction(action)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create a New Category"
            textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToReminder", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dataSource = segue.destination as! ReminderListViewController
        if let  indexPath = tableView.indexPathForSelectedRow
        {
            dataSource.category = categories[indexPath.row]
            //print(dataSource.selectedCategory?.name)
        }
    }
     
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")
        cell?.textLabel?.text = categories[indexPath.row].name
        return cell!
    }
    
   
    
    private func reloadData(){
        do{
            try categories = context.fetch(Category.fetchRequest())
        }catch{
            print("error Loading Data\(error)")
        }
        tableView.reloadData()
    }
    
}
