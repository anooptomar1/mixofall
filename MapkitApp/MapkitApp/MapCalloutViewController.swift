//
//  MapCalloutViewController.swift
//  MapkitApp
//
//  Created by Anoop tomar on 4/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit

class MapCalloutViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    var timer:NSTimer?
    var mapAnnotation = [MKAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        gotoDefaultLocation()
        var myAnnotation = MyAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(37.767912, -122.489184)
        mapAnnotation.append(myAnnotation)
        timer = NSTimer(timeInterval: 2, target: self, selector: "addAnnotationOnMap", userInfo: nil, repeats: false)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func gotoDefaultLocation(){
        var mapRegion = MKCoordinateRegion()
        mapRegion.center.latitude = 37.767912
        mapRegion.center.longitude = -122.489184
        mapRegion.span.latitudeDelta = 0.112872
        mapRegion.span.longitudeDelta = 0.109863
        
        mapview.setRegion(mapRegion, animated: true)
        
    }
    
    func addAnnotationOnMap(){
        mapview.addAnnotations(mapAnnotation)
    }
}


extension MapCalloutViewController: MKMapViewDelegate{
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var annotation = view.annotation
        
        if annotation is MyAnnotation{
            var alert = UIAlertController(title: "Clicked", message: "on golden gate bridge", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var returnAnnotationView: MKAnnotationView?
        if annotation is MyAnnotation{
            var myAnnotation = MyAnnotation()
            //annotation.coordinate = CLLocationCoordinate2DMake(37.767912, -122.489184)
            returnAnnotationView = myAnnotation.createAnnotationView(mapview, annotation: annotation)
            var rightButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            rightButton.addTarget(nil, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
            (returnAnnotationView as! MKPinAnnotationView).leftCalloutAccessoryView = rightButton
            var imageView = UIImageView(image: UIImage(named: "SFIcon")!)
            (returnAnnotationView as! MKPinAnnotationView).rightCalloutAccessoryView = imageView
            
        }
        return returnAnnotationView
    }
}