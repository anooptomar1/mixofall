//
//  TVCCViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 11/30/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class TVCCViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fetchedController: NSFetchedResultsController!
    var searchController: UISearchController!
    
    var restaurants: [Restaurant] = []//PopulateRestaurant.createRestaurantArray()
    let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    
    var searchResults: [Restaurant] = []
    
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // reset walkthrough
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "DoneFoodWalkthrough")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationAppearance()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        fetchResultsForRestaurants()
        addSearchBar()
        // hide tableview footer
        tableView.tableFooterView = UIView()
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        spinner.startAnimating()
    }
    
    func filterContentForSearchText(searchText: String){
        searchResults = restaurants.filter({ (restaurant:Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil)
            return nameMatch != nil
        })
    }
    
    deinit{
        searchController.removeFromParentViewController()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard NSUserDefaults.standardUserDefaults().boolForKey("DoneFoodWalkthrough") == false else{
            return
        }
        if let pageController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughController") as? WalkthroughPageViewController{
            presentViewController(pageController, animated: true, completion: nil)
        }
        
    }

    func addSearchBar(){
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.whiteColor()
        searchController.searchBar.barTintColor =  UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)
    }
    
    func fetchResultsForRestaurants(){
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            let fetchRequest = NSFetchRequest(entityName: "Restaurant")
            let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            if let managedContext = self.appDelegate?.managedObjectContext{
                self.fetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
                self.fetchedController.delegate = self
                do{
                    try self.fetchedController.performFetch()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.restaurants = self.fetchedController.fetchedObjects as! [Restaurant]
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                    })
                }
                    catch{
                    print(error)
                }
            }
        }
        
        
    }
    
    func reloadRestaurants(){
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        do{
            restaurants = try appDelegate?.managedObjectContext.executeFetchRequest(fetchRequest) as! [Restaurant]
            tableView.reloadData()
        }catch{
                print(error)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newRestaurantSegue"{
            let vc = segue.destinationViewController as! NewRestaurantTableViewController
            vc.delegate = self
        }
    }
    
    func navigationAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor(red: 242.0/255.0, green: 116.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0){
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: barFont]
        }
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // navigationController?.hidesBarsOnSwipe = true
    }
    
}

extension TVCCViewController: UITableViewDataSource, UITableViewDelegate{
        
        func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
            let restaurant = restaurants[indexPath.row]
            
            let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Share") { (action: UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                let defaultText = "Just checking in at \(restaurant.name)"
                let imageToShare = UIImage(data: restaurant.image)
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare!], applicationActivities: nil)
                self.presentViewController(activityController, animated: true, completion: nil)
            }
        
            let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete") { (action: UITableViewRowAction, index: NSIndexPath) -> Void in
                let restaurantToDelete = self.fetchedController.objectAtIndexPath(indexPath) as! Restaurant
                if let managedContext = self.appDelegate?.managedObjectContext{
                    managedContext.deleteObject(restaurantToDelete)
                    do{
                        try managedContext.save()
                    }catch{
                        print(error)
                    }
                }
            
                //self.restaurants.removeAtIndex(indexPath.row)
            
                //self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        
            shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
            deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
            return [deleteAction, shareAction]
        }
        
        func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
            return indexPath
        }
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
            // call handler
            let callHandler = { (action: UIAlertAction) -> Void in
                let callAlert = UIAlertController(title: "Service Unavailable", message: "Sorry, the call service is unavailable at the moment. Please try in few light years", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                callAlert.addAction(okAction)
                self.presentViewController(callAlert, animated: true, completion: nil)
            }
            
            let restaurant = searchController.active ? searchResults[indexPath.row] : restaurants[indexPath.row]
            
            // like handler
            let likeHandler = {
                (action: UIAlertAction) -> Void in
                let cell = tableView.cellForRowAtIndexPath(indexPath)
                if restaurant.isVisited.boolValue{
                    cell?.accessoryType = UITableViewCellAccessoryType.None
                    restaurant.isVisited = false
                }else{
                    cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                    restaurant.isVisited = true
                }
            }
    
            // call action
            let callAction = UIAlertAction(title: "Call \(restaurant.phoneNumber)", style: UIAlertActionStyle.Default,handler: callHandler)
            // like action
            let likeAction = restaurant.isVisited.boolValue ? UIAlertAction(title: "I've not been here before", style: UIAlertActionStyle.Default, handler: likeHandler) : UIAlertAction(title: "I've been here before", style: UIAlertActionStyle.Default, handler: likeHandler)
    
                
            // details action
                let detailsAction = UIAlertAction(title: "\(restaurant.name)'s Details", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
                    let detailsVC = self.storyboard?.instantiateViewControllerWithIdentifier("restaurantDetails") as! RestaurantDetailsViewController
                    detailsVC.restaurant = restaurant
                    self.navigationController?.pushViewController(detailsVC, animated: true)
                }
            // about action
            let aboutAction = UIAlertAction(title: "About app", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
                if let aboutVC = self.storyboard?.instantiateViewControllerWithIdentifier("aboutFood") as? AboutFoodViewController{
                    self.navigationController?.pushViewController(aboutVC, animated: true)
                }
            }
            
            // cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            optionMenu.addAction(callAction)
            optionMenu.addAction(likeAction)
            optionMenu.addAction(cancelAction)
            optionMenu.addAction(detailsAction)
            optionMenu.addAction(aboutAction)
            self.presentViewController(optionMenu, animated: true, completion: nil)
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchController.active{
                return searchResults.count
            }else{
                return restaurants.count
            }
        }
    
        func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            if searchController.active{
                return false
            }else{
                return true
            }
        }
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RestaurantTableViewCell
            let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            cell.thumbnailImageView.image = UIImage(data: restaurant.image)
            cell.nameLabel.text = restaurant.name
            cell.locationLabel.text = restaurant.location
            cell.typeLabel.text = restaurant.type
                cell.accessoryType = restaurant.isVisited.boolValue ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
            return cell
        }
}

extension TVCCViewController: NewRestaurantTableViewControllerDelegate{
    func didSavedChanges(newRestaurantTableViewController: NewRestaurantTableViewController, saved: Bool) {
        if saved{
            print("saved new restaurant")
        }
    }
}

extension TVCCViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type{
    case .Insert:
            if let _newIndexPath = newIndexPath{
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: UITableViewRowAnimation.Right)
            }
    case .Delete:
            if let _indexPath = indexPath{
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            }
    case .Update:
            if let _indexPath = indexPath{
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            }
    default:
        tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}

extension TVCCViewController: UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }
}
