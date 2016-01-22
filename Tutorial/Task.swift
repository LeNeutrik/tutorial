//
//  Task.swift
//  Tutorial
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var done: NSNumber
    @NSManaged var name: String
    @NSManaged var order: NSNumber
    @NSManaged var job: NSManagedObject

}
