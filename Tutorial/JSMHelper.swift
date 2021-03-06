//
//  File.swift
//  Tutorial
//
//  Created by Michael on 21.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//


import Foundation
import UIKit

class JSMHelper {
    
    static func delayOnMainQueue(delay: NSTimeInterval, closure:() -> Void) {
        JSMHelper.delayOnQueue(delay,queue: dispatch_get_main_queue(), closure: closure)
    }
    
    static func delayOnQueue(delay:NSTimeInterval, queue: dispatch_queue_t, closure: () -> Void){
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime,queue,closure)
    }
    
    static func singleTextFieldDialogTitle(title: String, message: String, placeholder: String, textFieldValue: String, ok: String, cancel: String, okClosure: (text:String) -> Void) -> UIAlertController {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        controller.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = placeholder
            textField.text = textFieldValue
        }
        
        let okAction = UIAlertAction(title: ok, style: .Default) { (action) -> Void in
            
            if let textField = controller.textFields?.first as UITextField! where !textField.text!.isEmpty {
                okClosure(text: textField.text!)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel , handler: nil)
        
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        return controller
    }
    
    static func dialogWithTitle(title: String, message: String,  ok: String, cancel: String, okClosure: () -> Void) -> UIAlertController {
        
        let controller = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        
        let okAction = UIAlertAction(title: ok, style: .Default) { (action) -> Void in
            okClosure()
        }
        
        let cancelAction = UIAlertAction(title: cancel, style: .Cancel , handler: nil)
        
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        return controller
    }
}