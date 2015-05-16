//
//  CDViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/15/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class CDViewController: UIViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var status: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSave(sender: UIButton) {
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext!)
        let contact = Contacts(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        contact.name = name.text
        contact.address = address.text
        contact.phone = phone.text
        
        var error: NSError?
        
        managedObjectContext?.save(&error)
        
        if let err = error{
            status.text = err.localizedDescription
        }else{
            status.text = "\(name.text) saved successfully"
            name.text = ""
            address.text = ""
            phone.text = ""
        }
    }
    
    @IBAction func onFind(sender: UIButton) {
        let entityDescription = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: managedObjectContext!)
        let request = NSFetchRequest()
        request.entity = entityDescription!
        let predicate = NSPredicate(format: "(name = %@)", name.text)
        request.predicate = predicate
        
        var error: NSError?
        var objects = managedObjectContext?.executeFetchRequest(request, error: &error)
        if let result = objects{
            if result.count > 0{
                let match = result[0] as! NSManagedObject
                
                name.text = match.valueForKey("name") as! String
                address.text = match.valueForKey("address") as! String
                phone.text = match.valueForKey("phone") as! String
                status.text = "Matches found: \(result.count)"
            }else{
                status.text = "No match found :("
            }
        }
    }
}
