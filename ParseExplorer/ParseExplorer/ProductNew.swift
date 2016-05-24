//
//  ProductNew.swift
//  ParseExplorer
//
//  Created by Anoop tomar on 12/27/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
class ProductNew {
    var title: String?
    var subtitle: String?
    var price: Double?
    var category: ProdCategory?
    
    func saveInBackground(){
        let product = PFObject(className: "Product")
        product["title"] = title
        product["subtitle"] = subtitle
        product["price"] = price
        
        if category != nil{
            let query = PFQuery(className: "ProductCategory")
            query.whereKey("title", equalTo: category!.title!)
            query.findObjectsInBackgroundWithBlock({ (object:[PFObject]?, error:NSError?) -> Void in
                if object!.count > 0{
                    product["category"] = object!.first
                    product.saveInBackground()
                }else{
                    NSOperationQueue().addOperationWithBlock({ () -> Void in
                        let cat = ProdCategory()
                        cat.title = self.category!.title!
                        cat.save()
                        query.findObjectsInBackgroundWithBlock({ (obj:[PFObject]?, err:NSError?) -> Void in
                            if obj != nil{
                                product["category"] = obj!.first
                                product.saveInBackground()
                            }
                        })
                    })
                }
            })
        }
        
    }
}

class ProdCategory{
    var title: String?
    
    func saveInBackground(){
        let category = PFObject(className: "ProductCategory")
        category["title"] = title
        category.saveInBackground()
    }
    
    func save(){
        let category = PFObject(className: "ProductCategory")
        category["title"] = title!
        do{
            try category.save()
        }catch let err{
            print(err)
        }
    }
}