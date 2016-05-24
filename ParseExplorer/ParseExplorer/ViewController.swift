//
//  ViewController.swift
//  ParseExplorer
//
//  Created by Anoop tomar on 12/26/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        queryRelationByRelationObject()
        
    }
    
    func queryRelationByRelationObject(){
        NSOperationQueue().addOperationWithBlock { () -> Void in
            let query = PFQuery(className: "Author")
            query.whereKey("name", containsString: "Johny")
            query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
                if objects?.count > 0{
                    let author = objects![0]
                    let query2 = PFQuery(className: "book")
                    query2.whereKey("authors", equalTo: author)
                    query2.findObjectsInBackgroundWithBlock({ (books: [PFObject]?, error: NSError?) -> Void in
                        if books!.count > 0{
                            print(books![0]["title"])
                        }
                    })
                }
            }
        }
    }
    
    func queryRelation(){
        // create query for book
        let query = PFQuery(className: "book")
        // add filter for book title
        query.whereKey("title", equalTo: "Art of business")
        // find book first
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            if objects?.count > 0 {
                let book = objects![0]
                // find relation for found book
                let relation = book.relationForKey("authors")
                // get query for relation
                let query = relation.query()
                // execute relation query
                query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
                    for obj in objects!{
                        print(obj["name"])
                    }
                })
            }
        }
    }
    
    func parseRelations(){
        NSOperationQueue().addOperationWithBlock { () -> Void in
            // create author objects
            let author1 = PFObject(className: "Author")
            let author2 = PFObject(className: "Author")
            let author3 = PFObject(className: "Author")
            author1["name"] = "Johny Walker"
            author2["name"] = "Chris Gardner"
            author3["name"] = "Kevin O leri"
            do{
                // save authors before creating relation
                try author1.save()
                try author2.save()
                try author3.save()
            }catch let err{
                print(err)
            }
            
            // create
            let book = PFObject(className: "book")
            book["title"] = "Art of business"
            book["category"] = "Nonfiction"
            
            // create relation on book with name authors
            let relation = book.relationForKey("authors")
            relation.addObject(author1)
            relation.addObject(author2)
            relation.addObject(author3)
            
            // save book and all objects in parse
            book.saveInBackground()
        }
    }
    
    func findAllProgrammingBook(){
        let query = PFQuery(className: "Product")
        
        let innerQuery = PFQuery(className: "ProductCategory")
        innerQuery.whereKey("title", equalTo: "Programming Books")
        
        query.whereKey("category", matchesQuery: innerQuery)
       
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error: NSError?) -> Void in
            if objects?.count > 0{
                for product in objects!{
                    print(product.objectForKey("title")!)
                }
            }
        }
    }
    
    func createNewProductCategory(){
        let category = ProdCategory()
        category.title = "Programming Books"
        category.saveInBackground()
    }
    
    func createNewProductWithCategory(){
        let product = ProductNew()
        product.title = "The Martian"
        product.subtitle = "Andy"
        product.price = 59.99
        
        let cat = ProdCategory()
        cat.title = "Fiction"
        
        product.category = cat
        product.saveInBackground()
    }
    
    func findProductWithCategory(cat: ProductCategory){
        let query = PFQuery(className: "Product")
        query.whereKey("category", equalTo: cat)
        query.findObjectsInBackgroundWithBlock({ (obj: [PFObject]?, error: NSError?) -> Void in
            if obj != nil{
                for p in obj as! [Product]{
                    print("\(p.title) : \(p.category!.title)")
                }
            }
        })
    }
    
    func createProductWithCategory(){
        let product = Product()
        product.title = "Learning Parse in Swift, 5th Edition"
        product.subTitle = "iOS Swift"
        product.unitPrice = 99.99
        product.priceUnit = "ea"
        
        let cat: ProductCategory = ProductCategory()
        cat.title = "Programming books"
        
        product.category = cat
        
        product.saveInBackgroundWithBlock {[weak self] (success:Bool, error:NSError?) -> Void in
            if success == true{
                self!.findProductWithCategory(cat)
            }
        }
        
        
    }
    
    func queryBuilder() -> PFQuery{
        let query = PFQuery(className: "Product")
        
        // apply where clause
        query.whereKey("title", containsString: "Swift")
        
        // apply sorting
        query.orderByAscending("title")
        
        // by default query gets 100 objects, set limit to 2 for testing
        //query.limit = 2
        
        // get next set of items
        //query.skip = 2
        
        return query
    }
    
    
    func queryProducts(){
        let query = queryBuilder()
        var products: [Product] = []
        
        // get all objects in Product class
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            if objects != nil{
                products = objects as! [Product]
            }
            for product in products{
                print(product.title!)
            }
            
        }
        
        
    }
    
    func createProduct(){
        let product = Product()
        product.title = "The Swift has awakened"
        product.subTitle = "iOS Swift"
        product.unitPrice = 199.99
        product.priceUnit = "ea"
        product.saveInBackground()
    }
}

