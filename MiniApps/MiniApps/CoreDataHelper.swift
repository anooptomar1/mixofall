//
//  CoreDataHelper.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/29/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHelper{
    var modelName: String
    var datastoreFileName: String

    init(modelName: String, datastoreFileName: String){
        self.modelName = modelName
        self.datastoreFileName = datastoreFileName
    }
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let documentsDirectory: NSURL = (NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as NSURL?)!
        let url = documentsDirectory.URLByAppendingPathComponent(self.datastoreFileName)
        print("DEBUG: path to the sqllite file: \(url)")
        var error: NSError? = nil
        let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading application's saved data"
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "com.devtechie.com", code: 9999, userInfo: dict)
            print("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil{
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func newEntry(named: String) -> NSManagedObject?{
        if managedObjectContext == nil{
            return nil
        }
        let newManagedObject = NSEntityDescription.insertNewObjectForEntityForName(named, inManagedObjectContext: managedObjectContext!) as? NSManagedObject
        return newManagedObject
    }
    
    func saveContext(){
        let context = self.managedObjectContext!
        var error: NSError? = nil
        do {
            try context.save()
        } catch let error1 as NSError {
            error = error1
            print("Error: \(error?.localizedDescription)")
            abort()
        }
    }
}