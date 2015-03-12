//
//  MapsViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationViewControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var image: UIImage?
    var locationVC: LocationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationVC = self.storyboard?.instantiateViewControllerWithIdentifier("locationVC") as? LocationViewController
        locationVC!.delegate = self
    }
    
    func didSetLocation(location: CLLocationCoordinate2D) {
        var zoomLocation = CLLocationCoordinate2D(latitude: 39.281516, longitude: -76.580806)
        var span = MKCoordinateSpan(latitudeDelta: 0.18, longitudeDelta: 0.18)
        var region = MKCoordinateRegion(center: zoomLocation, span: span)
    
        region.span = span;
        region.center = zoomLocation;
        self.mapView.setRegion(region, animated: true)
        self.mapView.regionThatFits(region)
        
//        var viewRegion = MKCoordinateRegionMakeWithDistance(location, 0.5 * 1609.344, 0.5 * 1609.344);
//        self.mapView.setRegion(viewRegion, animated: true)
//        self.mapView.regionThatFits(viewRegion)
    }

    @IBAction func onChoose(sender: UIButton) {
        var image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.modalPresentationStyle = UIModalPresentationStyle.Popover
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
        
        self.presentViewController(locationVC!, animated: true, completion: nil)
    }

}
