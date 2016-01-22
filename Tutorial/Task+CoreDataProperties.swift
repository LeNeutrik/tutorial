//
//  Task+CoreDataProperties.swift
//  Tutorial
//
//  Created by Michael on 19.01.16.
//  Copyright © 2016 de.Michael-Dazjuk. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    static func  createTaskForJob (job: Job, withName name: String  ) -> Task{
        let task = NSEntityDescription.insertNewObjectForEntityForName(kTaskEntity, inManagedObjectContext: CoreData.sharedInstance.managedObjectContext!) as! Task
        task.job = job
        task.name = name
        task.order = CoreData.minIntegerValueForEntity(kTaskEntity, attributeName: kTaskOrderAttribute, predicate: NSPredicate(format: "job == %@", job)) - 1
        CoreData.sharedInstance.saveContext()
        return task
    }


}
