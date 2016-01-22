//
//  JobTableViewController.swift
//  Tutorial
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit
import CoreData

extension JobTableViewController : NSFetchedResultsControllerDelegate{
    
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

class JobTableViewController: UITableViewController  {
    
    private lazy var fetchedResultsController:NSFetchedResultsController! = {
        let request = NSFetchRequest(entityName: kJobEntity)
        request.sortDescriptors = [NSSortDescriptor(key: kJobOrderAttribute, ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreData.sharedInstance.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        (try! fetchedResultsController.performFetch())
        return fetchedResultsController
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("titleJobViewController" , tableName: nil, bundle: NSBundle.mainBundle(), value: "Jobs", comment: "it is a navigation bar title")
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addJob:")
        let editButton = UIBarButtonItem(barButtonSystemItem: .Organize, target: editButtonItem().target, action: editButtonItem().action)
        let deleteAllButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: "deleteAll:")
        navigationItem.setRightBarButtonItems([addButton, editButton, deleteAllButton],animated: true)
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier == kTaskTableViewController {
            if let indexPath = tableView.indexPathForSelectedRow, job = fetchedResultsController.objectAtIndexPath(indexPath) as? Job {
                if let controller = segue.destinationViewController as? TaskTableViewController{
                    controller.job = job
                }
            }
        }
    }
    
    // MARK: - barButtonItemActions
    func addJob(sender:UIBarButtonItem) {
        
        let title = NSLocalizedString("titleCreateJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Create new job", comment: "title in alert controller")
        
        let placeholder = NSLocalizedString("placeholderCreateJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Job", comment: "placeholder for input textField")
        let message = NSLocalizedString("messageCreateJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Type in or dictate a jobname. Press 'Ok' to save. The dialog will pop up again for you, for easily creating the next job. Press 'Cancel' if your job list is complete for now", comment: "message in alertController")
        let ok = NSLocalizedString("okButtonCreateJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Ok", comment: "button  label")
        let cancel = NSLocalizedString("cancelButtonCreateJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Cancel", comment: "button  label")
        
        let dialog = JSMHelper.singleTextFieldDialogTitle(title, message: message, placeholder: placeholder, textFieldValue: "", ok: ok, cancel: cancel) {[weak self] (text) -> Void in
            
            Job.createJobWithName(text)
            
            JSMHelper.delayOnMainQueue(0.3) { () -> Void in
                self?.addJob(sender)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(kJobTableViewCell, forIndexPath: indexPath) as! JobTableViewCell
        
        cell.job = fetchedResultsController.objectAtIndexPath(indexPath) as! Job
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let job = fetchedResultsController.objectAtIndexPath(indexPath) as! Job
            job.delete()
        }
    }
    
    override func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        if let jobCell = tableView.cellForRowAtIndexPath(indexPath) as? JobTableViewCell {
            jobCell.disableNambeButton()
        }
    }
    
    override func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
        if let jobCell = tableView.cellForRowAtIndexPath(indexPath) as? JobTableViewCell {
            jobCell.enableNameButton()
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        if sourceIndexPath.row == destinationIndexPath.row {return}
        
        let source = fetchedResultsController.objectAtIndexPath(sourceIndexPath) as! NSManagedObject
        let destination = fetchedResultsController.objectAtIndexPath(destinationIndexPath) as! NSManagedObject
        
        CoreData.move (kJobEntity, orderAttributeName: kJobOrderAttribute, source: source, toDestination: destination)
    }
}
