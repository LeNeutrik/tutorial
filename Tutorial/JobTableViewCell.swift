//
//  JobTableViewCell.swift
//  Tutorial
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    var job:Job! {
        didSet {
            nameButtonOutlet.setTitle(job.name + " order:\(job.order)", forState: .Normal)
        }
    }
    
    @IBOutlet weak var nameButtonOutlet: UIButton!{
        didSet {
            nameButtonOutlet.layer.cornerRadius = 6.0
            nameButtonOutlet.layer.borderColor = UIColor.lightGrayColor().CGColor
            nameButtonOutlet.layer.borderWidth = 1.0
            nameButtonOutlet.layer.backgroundColor =  UIColor(white: 0.99 , alpha: 1.0).CGColor
        }
    }
    @IBOutlet weak var doneCircleImageViewOutlet: UIImageView!
    
    
    @IBAction func nameButtonAction(sender: AnyObject) {
        //print(__FILE__ + " [\(__LINE__)]: " + __FUNCTION__)
        
        editJob(job)
    }
    
    func editJob (job:Job){
        
        let title = NSLocalizedString("titleEditJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Edit job", comment: "title in alert controller")
        
        let placeholder = NSLocalizedString("placeholderEditJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Job", comment: "placeholder for input textField")
        let message = NSLocalizedString("messageCreatJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Change jobname, but do not delete all characters ;-)", comment: "message in alertController")
        let ok = NSLocalizedString("okButtonEditJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Ok", comment: "button  label")
        let cancel = NSLocalizedString("cancelButtonEditJobDialog", tableName: nil, bundle: NSBundle.mainBundle(), value: "Cancel", comment: "button  label")
        
        let dialog = JSMHelper.singleTextFieldDialogTitle(title, message: message, placeholder: placeholder, textFieldValue: job.name, ok: ok, cancel: cancel) {(text) -> Void in
            
            job.name = text
            CoreData.sharedInstance.saveContext()
        }
        
        viewController?.presentViewController(dialog, animated: true, completion: nil)
        
    }
    
    func enableNameButton () {
        nameButtonOutlet.enabled = true
    }
    
    func disableNambeButton() {
        nameButtonOutlet.enabled = false
    }
    
}
