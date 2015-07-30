//
//  Ingredient.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/29/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
import CoreData

@objc(Ingredient)
class Ingredient: NSManagedObject {

    @NSManaged var measurement: NSNumber
    @NSManaged var ingredient: String
    @NSManaged var parentRecipe: Recipe

}
