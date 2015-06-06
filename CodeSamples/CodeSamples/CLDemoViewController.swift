//
//  CLDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreLocation

class CLDemoViewController: UIViewController {

    @IBOutlet weak var currentLatitude: UILabel!
    @IBOutlet weak var currentLongitude: UILabel!
    @IBOutlet weak var hAccuracy: UILabel!
    @IBOutlet weak var currentAltitude: UILabel!
    @IBOutlet weak var vAccuracy: UILabel!
    @IBOutlet weak var discover: UILabel!
    
    var startLocation: CLLocation?
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        startLocation = nil
        
//        locationManager?.requestWhenInUseAuthorization()
//        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//        // distance filter is used to trigger location update only if
//        // the device has traveled specified distance
//        // if distance filter is not configured the location update will fire often
//        // better to use distance filter to save battery life
//        locationManager?.distanceFilter = 1500.0
//        locationManager?.delegate = self
//        locationManager?.startUpdatingLocation()
    }
    
    
    @IBAction func onReset(sender: UIButton) {
        startLocation = nil
    }

   
}

extension CLDemoViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var lastLocation = locations[locations.count - 1] as! CLLocation
        currentLatitude.text = "\(lastLocation.coordinate.latitude)"
        currentLongitude.text = "\(lastLocation.coordinate.longitude)"
        hAccuracy.text = "\(lastLocation.horizontalAccuracy)"
        currentAltitude.text = "\(lastLocation.altitude)"
        vAccuracy.text = "\(lastLocation.verticalAccuracy)"
        
        // demo only
        //  if user on a 10 mile trip that returns to the start location the distance will be displayed as 0 (since the start and end points are the same).
        if startLocation == nil{
            startLocation = lastLocation
        }
        
        var distanceBetween: CLLocationDistance = lastLocation.distanceFromLocation(startLocation)
        
        discover.text = String(format:"%.2f", distanceBetween)
        
//        CLLocation contains following
//        Latitude
//        Longitude
//        Horizontal Accuracy (meters)
//        Altitude (meters)
//        Altitude Accuracy (meters)
//        distance beteween two points can be calculated using 
        
//        var distance: CLLocationDistance = endLocation.distanceFromLocation(startLocation)
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
    }
}
