//
//  ViewController.swift
//  Today
//
//  Created by Santhosh on 23/02/22.
//

import UIKit
import CoreData

class ReminderListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    private var reminderListDataSource:ReminderListDataSource?
    
    static let showDetailViewSegue = "ShowDetailViewSegue"
    
    static let mainStoryBoard = "Main"
    
    static let detailViewControllerIdentifier = "DetailViewController"
    
    @IBOutlet var progressBar:CircularProgressBar!
    @IBOutlet var filterSegment: UISegmentedControl!
    
    
    
   private  var progress:Double {
       return reminderListDataSource!.progress
    }
    private var filter: ReminderListDataSource.Filter {
        return ReminderListDataSource.Filter(rawValue: filterSegment.selectedSegmentIndex) ?? .today
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Self.showDetailViewSegue,
           let destination = segue.destination as? DetailViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell)
        {
            let rowIndex = indexPath.row
            
            guard let reminder = reminderListDataSource?.reminder(at: rowIndex) else {
                fatalError("Couldn't find data source for reminder list.")
            }
            destination.configure(reminder: reminder, editAction: { reminder in
                print("Seque")
                self.reminderListDataSource?.retriveData()
                self.reminderListDataSource?.update(reminder, at: rowIndex)
               // self.tableView.reloadRows(at: [indexPath], with: .automatic)
                self.tableView.reloadData()
            })
        }
    }
    @objc func updateProgress() {
        
        progressBar.setProgress(to: self.progress, withAnimation: true)
        //progress = progress + 0.06
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderListDataSource = ReminderListDataSource()
        tableView.dataSource = reminderListDataSource
        reminderListDataSource?.retriveData()
        progressBar.labelSize = 30
        progressBar.safePercent = 100
        reminderListDataSource?.calculateProgress()
        let timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        //timer.fire()
        RunLoop.main.add(timer, forMode: .common)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let navigationController = navigationController,
           navigationController.isToolbarHidden {
            navigationController.setToolbarHidden(false, animated: animated)
        }
    }
    
    @IBAction func addButtonTriggered(_ sender: UIBarButtonItem) {
        addReminder()
    }

    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        reminderListDataSource?.filter = filter
        tableView.reloadData()
    }
    

    private func addReminder() {
        let storyboard = UIStoryboard(name: Self.mainStoryBoard, bundle: nil)
        let detailViewController: DetailViewController = storyboard.instantiateViewController(identifier: Self.detailViewControllerIdentifier)
        let reminder = Reminderlist(context: context)
        reminder.title = "New Reminder"
        reminder.id = UUID().uuidString
        reminder.notes = ""
        reminder.date = Date()

        
        detailViewController.configure(reminder: reminder, isNew: true, addAction: { reminder in
            if let index = self.reminderListDataSource?.add(reminder) {
                try! self.context.save()
                self.reminderListDataSource?.calculateProgress()
                self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            }
        })
        let navigationController = UINavigationController(rootViewController: detailViewController)
        present(navigationController, animated: true, completion: nil)
    }
}



