//
//  NewRestaurantTableViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/5/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreData

protocol NewRestaurantTableViewControllerDelegate: class{
    func didSavedChanges(newRestaurantTableViewController:NewRestaurantTableViewController, saved: Bool)
}

class NewRestaurantTableViewController: UITableViewController {

    @IBOutlet weak var topImage:UIImageView!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var locationLabel: UITextField!
    @IBOutlet weak var phoneLabel: UITextField!
    
    
    @IBOutlet weak var beenHereButton: UIButton!
    @IBOutlet weak var typeLabel: UITextField!
    @IBOutlet weak var notBeenHereButton: UIButton!
    
    var beenHere: Bool = false
    
    weak var delegate: NewRestaurantTableViewControllerDelegate?
    
    var appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem()
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "handleCancelEvent")
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "handleSaveEvent")
        if let barFont = UIFont(name: "Avenir-Light", size: 20){
            cancelButton.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName: barFont], forState: UIControlState.Normal)
            saveButton.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: barFont], forState: UIControlState.Normal)
        }
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
        
        beenHereButton.backgroundColor = UIColor.darkGrayColor()
        notBeenHereButton.backgroundColor = UIColor.darkGrayColor()
    }

    func handleCancelEvent(){
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func toggleBeenHere(sender: UIButton){
        switch sender.tag{
        case 1:
            beenHereButton.backgroundColor = UIColor.redColor()
            notBeenHereButton.backgroundColor = UIColor.darkGrayColor()
            beenHere = true
            print("yes, been there")
        case 2:
            beenHereButton.backgroundColor = UIColor.darkGrayColor()
            notBeenHereButton.backgroundColor = UIColor.redColor()
            beenHere = false
            print("no, not yet")
        default:
            break
        }
    }
    
    func handleSaveEvent(){
        var invalidForm = false
        var message = ""
        if !validateField(nameLabel){
            message += "Restaurant name can't be blank\n"
            invalidForm = true
        }
        if !validateField(locationLabel){
            message += "Location can't be blank\n"
            invalidForm = true
        }
        if !validateField(typeLabel){
            message += "Type can't be blank\n"
            invalidForm = true
        }
        if !validateField(phoneLabel){
            message += "Phone number can't be blank"
            invalidForm = true
        }
        if invalidForm{
            showInvalidAlert(message)
            return
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { () -> Void in
            if let managedObjectContext = self.appDelegate?.managedObjectContext{
                self.restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
                self.restaurant.name = self.nameLabel.text!
                self.restaurant.type = self.typeLabel.text!
                self.restaurant.location = self.locationLabel.text!
                self.restaurant.phoneNumber = self.phoneLabel.text!
                if let restaurantImage = self.topImage.image{
                    self.restaurant.image = UIImagePNGRepresentation(restaurantImage)!
                }
                self.restaurant.isVisited = self.beenHere
                do {
                    try managedObjectContext.save()
                    self.delegate?.didSavedChanges(self, saved: true)
                }catch{
                    print(error)
                    return
                }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.navigationController?.popToRootViewControllerAnimated(true)
            })
        }
        }
    }
    
    func showInvalidAlert(message: String){
        let alertController = UIAlertController(title: "Validation Failed", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func validateField(field: UITextField)->Bool{
        return field.text?.characters.count > 0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.delegate = self
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}

extension NewRestaurantTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        topImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        topImage.contentMode = UIViewContentMode.ScaleAspectFill
        topImage.clipsToBounds = true
        
        // layout constraints
        let leadingConstraints = NSLayoutConstraint(item: topImage, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: topImage.superview, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0)
        leadingConstraints.active = true
        
        let trailingConstraints = NSLayoutConstraint(item: topImage, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: topImage.superview, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0)
        trailingConstraints.active = true
        
        let topConstraints = NSLayoutConstraint(item: topImage, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: topImage.superview, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        topConstraints.active = true
        
        let bottomConstaints = NSLayoutConstraint(item: topImage, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: topImage.superview, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        bottomConstaints.active = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}