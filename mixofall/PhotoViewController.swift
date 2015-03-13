//
//  PhotoViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MapKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var mapVIew: MKMapView!{
        didSet{
            mapVIew.delegate = self
        }
    }
    
    var currentImage: UIImage?
    var photoAnnotations = [PhotoMapAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onPhotoSelect(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension PhotoViewController: LocationViewControllerDelegate{
    func didSetLocation(locationViewController: LocationViewController, location: PhotoMapAnnotation) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        //navigationController?.popViewControllerAnimated(true)
        
        photoAnnotations.append(location)
        mapVIew.addAnnotations(photoAnnotations)
        mapVIew.showAnnotations(photoAnnotations, animated: true)
        
    }
}

extension PhotoViewController: UIImagePickerControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        currentImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        performSegueWithIdentifier("locationTag", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "locationTag"{
            let locationVC = segue.destinationViewController as LocationViewController
            locationVC.delegate = self
        }
    }
}

extension PhotoViewController: MKMapViewDelegate{
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let reuseId = "PhotoId"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView.canShowCallout = true
            let imageView = UIImageView(frame: CGRectMake(0, 0, 60, 60))
            if let cImage = currentImage{
                imageView.contentMode = UIViewContentMode.ScaleAspectFit
                imageView.image = cImage
                self.currentImage = nil
            }
            
            annotationView.leftCalloutAccessoryView = imageView
        }
        annotationView.annotation = annotation
        
        return annotationView
    }
}

extension PhotoViewController: UINavigationControllerDelegate{

}
