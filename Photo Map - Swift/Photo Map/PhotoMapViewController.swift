//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Anoop tomar on 3/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {
    
    var originalImage: UIImage?
    var editedImage: UIImage?
    
    var zoomLocation: CLLocationCoordinate2D?
    
    var locationVC: LocationsViewController?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func cameraButton(sender: UIButton) {
        var vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        vc.modalPresentationStyle = UIModalPresentationStyle.Popover
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationVC = self.storyboard?.instantiateViewControllerWithIdentifier("LocationVC") as? LocationsViewController
        locationVC!.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if zoomLocation != nil{
            var viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(zoomLocation!, 0.5 * 1609.344, 0.5 * 1609.344);
            self.mapView.setRegion(viewRegion, animated: true)
        }
    }

    func didSelectLocation(location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        annotation.title = "picture"
        mapView.addAnnotation(annotation)
        
        zoomLocation = location.coordinate
        
        var lat = zoomLocation!.latitude as NSNumber
        var lng = zoomLocation!.longitude as NSNumber
        var latString = "\(lat)"
        var lngString = "\(lng)"
        
        println("inside didselectlocation")
        println(latString + " " + lngString)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        originalImage = info[UIImagePickerControllerOriginalImage]  as? UIImage
        editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)

        var navVC = UINavigationController(rootViewController: locationVC!)
        self.presentViewController(navVC, animated: true, completion: nil)
    }
}
