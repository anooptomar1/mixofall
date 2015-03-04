//
//  DetailViewController.swift
//  taskList
//
//  Created by Anoop tomar on 3/2/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!

    @IBOutlet weak var locationText: UITextField!

    @IBOutlet weak var taskImage: UIImageView!
    
    var detailItem: TaskList? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: TaskList = self.detailItem {
            if let name = self.nameText {
                name.text = detail._name
            }
            if let location = self.locationText{
                location.text = detail._location
                taskImage.image = detail._taskImage
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    @IBAction func changeDetails(sender: AnyObject!){
        if sender === nameText{
            detailItem?._name = nameText.text
        }
        if sender === locationText{
            detailItem?._location = locationText.text
        }
    }

    @IBAction func changePicture(sender: AnyObject) {
        if(detailItem == nil){
            return
        }
        
        // dismiss keyboard
        dismissKeyboard(self)
        
        
        // check if user's device supports photolibrary source
        let hasPhotoLibrary = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        // check if user's device supports camera source
        let hasCamera = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // switch statement on touple
        switch(hasCamera, hasPhotoLibrary){
            
        // if user's device support both camera and photolib
        case (true, true):
            // create new UIAlertController with style as action sheet
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            // add action for take a picture option
            alert.addAction(UIAlertAction(title: "Take a picture", style: UIAlertActionStyle.Default, handler: {(_) in
                // local method to handle image after its been picked or taken
                self.presentImagePicker(UIImagePickerControllerSourceType.Camera)
            }))
            
            alert.addAction(UIAlertAction(title: "Choose a photo", style: UIAlertActionStyle.Default, handler: {(_) in
                self.presentImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(_) in
                
            }))
            
            // create popoverPresentationController for ipad
            if let popover = alert.popoverPresentationController{
                popover.sourceView = taskImage
                popover.sourceRect = taskImage.bounds
                popover.permittedArrowDirections = (.Up | .Down)
            }
            
            // present alert controller
            presentViewController(alert, animated: true, completion: nil)
        case (true, false):
            // if user's device support only photolib than no need to ask user for action just present the view
            presentImagePicker(UIImagePickerControllerSourceType.PhotoLibrary)
        case (false, true):
            // if user's device support only camera than no need to ask user for action just present the view
            presentImagePicker(UIImagePickerControllerSourceType.Camera)
        default: break;
        }
        
    }
    
    @IBAction func dismissKeyboard(sender: AnyObject?){
        view.endEditing(true)
    }
    
    // in order to handle imagePickerController, need to include UIImagePickerControllerDelegate and UINavigationController
    // after that this function can handle operation to take place after user has selected the image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        //get image from Info dictionary 
        // UIImagePickerControllerEditedImage will return image if user decided to edit image after taking the picture
        var image: UIImage! = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if image == nil{
            // UIImagePickerControllerOriginalImage will be selected if EditedImage is null
            image = info[UIImagePickerControllerOriginalImage] as UIImage
        }
        
        // if picker was camera than save image to photo album
        // don't do this for photo lib otherwise it will duplicate the picture in user's photolib
        if picker.sourceType == UIImagePickerControllerSourceType.Camera{
            // call this function to save image to photo album
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
        
        // UIImage provides only limited functionality so to do lower level operations fall back on Core Graphics
        // create cgImage from UIImage
        let cgImage = image.CGImage
        
        // calculate height for cgImage
        let height = Int(CGImageGetHeight(cgImage))
        
        // calculate width for cgImage
        let width = Int(CGImageGetWidth(cgImage))
        
        // create rect for crop
        var crop = CGRect(x: 0, y: 0, width: width, height: height)
        
        // check if image is in landscape or potrait mode
        // make image square
        if height > width{
            crop.size.height = crop.size.width
            // set new y location for the image
            crop.origin.y = CGFloat((height - width) / 2)
        }else{
            crop.size.width = crop.size.height
            crop.origin.x = CGFloat((width - height) / 2)
        }
        
        // Use CGImageCreateWithImageInRect method to create cropped image
        let croppedImage = CGImageCreateWithImageInRect(cgImage, crop)
        
        // scale dimension for new image
        let maxImageDimension: CGFloat = 320.0
        
        // scale image down to reduce image size on disc
        image = UIImage(CGImage: croppedImage, scale: max(crop.height / maxImageDimension, 1.0), orientation: image.imageOrientation)
        
        detailItem?._taskImage = image
        taskImage.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // dismiss image picker controller if
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentImagePicker(source: UIImagePickerControllerSourceType){
        // create UIImagePickerController
        let picker = UIImagePickerController()
        // set source type to the type that was selected when method was called
        picker.sourceType = source
        // set media type to control type of controls to be shown during camera taking picture
        // other values are [kUTTypeMovie] or [kUTTypeImage, kUTTypeMovie]
        // import MobileCoreServices for kUTType values
        picker.mediaTypes = [kUTTypeImage]
        picker.delegate = self
        
        if source == UIImagePickerControllerSourceType.PhotoLibrary{
            picker.modalPresentationStyle = UIModalPresentationStyle.Popover
        }
        
        if let popover = picker.popoverPresentationController{
            popover.sourceView = taskImage
            popover.sourceRect = taskImage.bounds
        }
        
        presentViewController(picker, animated: true, completion: nil)
    }
}

