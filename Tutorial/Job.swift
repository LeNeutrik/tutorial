//
//  Job.swift
//  Tutorial
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import Foundation
import CoreData

//@objc(Job)
class Job: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    @NSManaged var name: String
    @NSManaged var order: NSNumber
    @NSManaged var tasks: NSSet

}
