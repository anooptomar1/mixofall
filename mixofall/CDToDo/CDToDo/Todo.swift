//
//  Todo.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/5/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

@objc(Todo)
class Todo: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var desc: String
    @NSManaged var finished: NSNumber
    @NSManaged var due_date: NSDate
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
}
