//
//  Contacts.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/15/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
import CoreData

class Contacts: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var phone: String
    @NSManaged var name: String

}
