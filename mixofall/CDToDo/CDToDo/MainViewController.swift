//
//  MainViewController.swift
//  CDToDo
//
//  Created by Anoop tomar on 5/5/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    private var _fetchedResultController: NSFetchedResultsController!
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.estimatedRowHeight = 100
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tabbar.selectedItem = self.tabbar.items?[0] as? UITabBarItem
        
        var error: NSError?
        if !fetchedResultsController.performFetch(&error){
            showError(error!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableview.reloadData()
    }
    
    @IBAction func AddObject(sender: UIBarButtonItem) {
        let managedObjectContext = fetchedResultsController.managedObjectContext as NSManagedObjectContext
        let entity: NSEntityDescription = fetchedResultsController.fetchRequest.entity!
        var newHero = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: managedObjectContext) as! NSManagedObject
        
        var error: NSError?
        
        if !managedObjectContext.save(&error){
            showError(error!)
        }
        //self.performSegueWithIdentifier("detailsSegue", sender: newHero)
    }
    
    func showError(error: NSError){
        let title = NSLocalizedString("Error Saving Entity", comment: "Error Saving Entity")
        let message = NSLocalizedString("Error was \(error.description)", comment: "Error was \(error.description)")
        showAlertWithCompletion(title, message: message, buttonTitle: "OKie Dokie", completion: { (action: UIAlertAction!) -> Void in
        println("Alert message was just closed")
        })
    }
    
    func showAlertWithCompletion(title: String, message: String, buttonTitle:String = "OK", completion: ((UIAlertAction!) -> Void)!){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAlertAction = UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: completion)
        alert.addAction(okAlertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "detailsSegue"{
            if let _sender = sender as? NSManagedObject{
                return true
            }
        }
        return false
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailsSegue"{
            if let _sender = sender as? NSManagedObject{
                var detailsController = segue.destinationViewController as! DetailsTableViewController
                detailsController.hero = _sender
            }else{
                return
            }
//            }else{
//                showAlertWithCompletion("Hero details error", message: "some error", buttonTitle: "Damn!", completion: { (action: UIAlertAction!) -> Void in
//                    println("OOPS")
//                })
//            }
        }
    }
}

extension MainViewController: NSFetchedResultsControllerDelegate{
    private var fetchedResultsController: NSFetchedResultsController{
        get{
            if _fetchedResultController != nil{
                return _fetchedResultController
            }
            
            let fetchRequest = NSFetchRequest()
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            let entity = NSEntityDescription.entityForName("SuperHero", inManagedObjectContext: context!)!
            fetchRequest.entity = entity
            fetchRequest.fetchBatchSize = 20
            
            let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
            let sortDescriptor2 = NSSortDescriptor(key: "secretIdentity", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
            
            let aFetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: "name", cacheName: "SuperHero")
            aFetchResultsController.delegate = self
            _fetchedResultController = aFetchResultsController
            return _fetchedResultController
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableview.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableview.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch(type){
        case .Insert:
            self.tableview.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Left)
        
        case .Delete:
            self.tableview.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: UITableViewRowAnimation.Right)
        
        default:
            ()
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch(type){
        case .Insert:
            self.tableview.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Left)
        case .Delete:
            self.tableview.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Right)
        default:
            ()
        }
    }
}

extension MainViewController: UITableViewDelegate{
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.addButton.enabled = !editing
        self.tableview.setEditing(editing, animated: animated)
    }
}
extension MainViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = self.tableview.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TodoCell
        
        
        let aHero = fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        cell.setupCell(aHero.valueForKey("name") as! String, desc: aHero.valueForKey("secretIdentity") as! String, date: "Some")
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObjectContext = fetchedResultsController.managedObjectContext as NSManagedObjectContext
        if editingStyle == UITableViewCellEditingStyle.Delete{
            managedObjectContext.deleteObject(fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject)
            var error: NSError?
            if !managedObjectContext.save(&error){
                showError(error!)

            }else  if( editingStyle == UITableViewCellEditingStyle.Insert){
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedHero = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.performSegueWithIdentifier("detailsSegue", sender: selectedHero)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
