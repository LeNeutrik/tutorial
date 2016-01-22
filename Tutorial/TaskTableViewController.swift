//
//  TaskTableViewController.swift
//  Tutorial
//
//  Created by Michael on 22.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit
import CoreData

extension TaskTableViewController : NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            print("Insert")
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Update:
            print("Update")
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Delete:
            print("Delete")
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Move:
            print("Move")
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }
}


class TaskTableViewController: UITableViewController {
    
    var job:Job!{
        didSet{
            title = job.name
            
        }
    }
    
    private lazy var fetchedResultsController:NSFetchedResultsController! = {
        let request = NSFetchRequest(entityName: kTaskEntity)
        request.sortDescriptors = [NSSortDescriptor(key: kTaskOrderAttribute, ascending: true)]
        request.predicate = NSPredicate(format: "job == %@", self.job)
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreData.sharedInstance.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        (try! fetchedResultsController.performFetch())
        return fetchedResultsController
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addTask:")
        let editButton = UIBarButtonItem(barButtonSystemItem: .Organize, target: editButtonItem().target, action: editButtonItem().action)
        let deleteAllButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "deleteAll:")
        navigationItem.setRightBarButtonItems([addButton, editButton, deleteAllButton],animated: true)
    }
    
    // MARK: - barButtonItemActions
    func addTask(sender:UIBarButtonItem) {
        
        let title = NSLocalizedString("titleCreateTaskDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Create new task", comment: "title in alert controller")
        
        let placeholder = NSLocalizedString("placeholderCreateTaskDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Task", comment: "placeholder for input textField")
        let message = NSLocalizedString("messageCreateTaskDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Name your task. Press 'Ok' to save. The dialog will pop up again for you, for easily creating the next task. Press 'Cancel' if your task list is complete for now", comment: "message in alertController")
        let ok = NSLocalizedString("okButtonCreateTaskDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Ok", comment: "button  label")
        let cancel = NSLocalizedString("cancelButtonCreateTaskDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Cancel", comment: "button  label")
        
        let dialog = JSMHelper.singleTextFieldDialogTitle(title, message: message, placeholder: placeholder, textFieldValue: "", ok: ok, cancel: cancel) {[weak self] (text) -> Void in
            
            Task.createTaskForJob(self!.job, withName:text)
            
            JSMHelper.delayOnMainQueue(0.3) { () -> Void in
                self?.addTask(sender)
            }
        }
        
        presentViewController(dialog, animated: true, completion: nil)
    }
    
    func deleteAll(sender:UIBarButtonItem) {
        
        let title = NSLocalizedString("titleDeleteAllJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Delete All jobs", comment: "title in alert controller")
        
        let message = NSLocalizedString("messageDeleteAllJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Would you really like to delete all jobs?", comment: "message in alertController")
        let ok = NSLocalizedString("okButtonDeleteAllJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Yes, Delete All Jobs", comment: "button  label")
        let cancel = NSLocalizedString("cancelButtonDeleteAllDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Cancel", comment: "button  label")
        
        let dialog = JSMHelper.dialogWithTitle(title, message: message, ok: ok, cancel: cancel) {Job.deleteAll()}
        
        presentViewController(dialog, animated: true, completion: nil)
    }

    
        // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (fetchedResultsController.sections?[section] as NSFetchedResultsSectionInfo!)?.numberOfObjects ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kTaskTableViewCell, forIndexPath: indexPath) as! TaskTableViewCell
        
        cell.task = fetchedResultsController.objectAtIndexPath(indexPath) as! Task
        
        return cell
    }
    
    
}
