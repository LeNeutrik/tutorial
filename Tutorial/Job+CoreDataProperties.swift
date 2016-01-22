//
//  Job+CoreDataProperties.swift
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

private var jobsDidSaveArray = [Job]()

extension Job {
    
    static func  createJobWithName (name: String) -> Job{
        let job = NSEntityDescription.insertNewObjectForEntityForName(kJobEntity, inManagedObjectContext: CoreData.sharedInstance.managedObjectContext!) as! Job
        job.name = name
        job.order = CoreData.minIntegerValueForEntity(kJobEntity, attributeName: kJobOrderAttribute) - 1
        CoreData.sharedInstance.saveContext()
        return job
    }
    
    static func deleteAll(){
        
        let request = NSFetchRequest(entityName: kJobEntity)
        
        
        if let allJobs = ( try! CoreData.sharedInstance.managedObjectContext?.executeFetchRequest(request)) as? [Job]{
            for job in allJobs{
                CoreData.sharedInstance.managedObjectContext?.deleteObject(job)
            }
            CoreData.sharedInstance.saveContext()
        }
    }
    
    func delete() {
        
        CoreData.sharedInstance.managedObjectContext?.deleteObject(self)
        CoreData.sharedInstance.saveContext()
    }
    
    
    
    
    /*
    override func willSave() {
    super.willSave()
    
    if let index = jobsDidSaveArray.indexOf(self){
    jobsDidSaveArray.removeAtIndex(index)
    } else{
    
    jobsDidSaveArray.append(self)
    if inserted {
    
    let minValue = CoreData.minIntegerValueForEntity(kJobEntity, attributeName: kJobOrderAttribute)
    order = minValue - 1
    
    }
    }
    }
    */
}
