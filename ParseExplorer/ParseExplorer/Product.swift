//
//  Product.swift
//  ParseExplorer
//
//  Created by Anoop tomar on 12/26/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
class Product: PFObject, PFSubclassing{
    @NSManaged var title: String?
    @NSManaged var subTitle: String?
    @NSManaged var unitPrice: NSNumber?
    @NSManaged var priceUnit: String?
    @NSManaged var category: ProductCategory?
    

    override class func initialize(){
        struct Static{
            static var onceToken: dispatch_once_t = 0
        }
        dispatch_once(&Static.onceToken){
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Product"
    }
}

// class to hold product category
// product category is held as pointer in parse
class ProductCategory: PFObject, PFSubclassing{
    
    @NSManaged var title: String?
    
    override class func initialize(){
        struct Static{
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken){
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "ProductCategory"
    }
}