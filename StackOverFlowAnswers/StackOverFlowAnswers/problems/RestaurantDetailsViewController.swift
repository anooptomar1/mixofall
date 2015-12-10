//
//  RestaurantDetailsViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/3/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

class RestaurantDetailsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var restaurant: Restaurant!
    @IBOutlet weak var likeStatus: UIButton!
    
    @IBOutlet weak var headerImage: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerImage.image = UIImage(data: restaurant.image)
        self.automaticallyAdjustsScrollViewInsets = false
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableview.tableFooterView = UIView(frame: CGRectZero)
        tableview.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        tableview.rowHeight = 36.0
        tableview.estimatedRowHeight = UITableViewAutomaticDimension
        title = restaurant.name
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        setRatingIcon(restaurant.rating)
    }

    @IBAction func close(segue: UIStoryboardSegue){
        if let reviewController = segue.sourceViewController as? RatingsViewController{
            if let rating = reviewController.rating{
                setRatingIcon(rating)
                self.restaurant.rating = rating
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                    if let managedContext = (UIApplication.sharedApplication().delegate as? AppDelegate)?.managedObjectContext{
                        do{
                            try managedContext.save()
                        }catch{
                            print(error)
                        }
                    }
                })
            }
        }
    }
    
    func setRatingIcon(rating: String){
        switch rating{
        case "100":
            likeStatus.setImage(UIImage(named: "dislike"), forState: UIControlState.Normal)
        case "200":
            likeStatus.setImage(UIImage(named: "good"), forState: UIControlState.Normal)
        case "300":
            likeStatus.setImage(UIImage(named: "great"), forState: UIControlState.Normal)
        default:
            likeStatus.setImage(UIImage(named: "rating"), forState: UIControlState.Normal)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "restaurantMapSegue"{
            let vc = segue.destinationViewController as! RestaurantMapViewController
            vc.restaurant = restaurant
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.hidesBarsOnSwipe = false
//        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension RestaurantDetailsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! RestaurantDetailCellTableViewCell
        
        switch indexPath.row{
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restaurant.isVisited.boolValue) ? "Yes, Been there" : "Not yet"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row{
        case 2:
            return UITableViewAutomaticDimension
        default:
            return 36.0
        }
    }
    
}