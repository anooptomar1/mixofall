//
//  Recipe.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/29/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
import CoreData

@objc(Recipe)
class Recipe: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var serves: NSNumber
    @NSManaged var recipeDescription: String
    @NSManaged var ingredients: Ingredient

}
