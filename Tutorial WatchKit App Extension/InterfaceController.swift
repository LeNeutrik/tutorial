//
//  InterfaceController.swift
//  Tutorial WatchKit App Extension
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var helloWorldLabelOutlet: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        helloWorldLabelOutlet.setText(kAppGroup)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
