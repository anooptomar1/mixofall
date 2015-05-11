//
//  MapViewController.swift
//  GISExplorer
//
//  Created by Anoop tomar on 4/24/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var currentSpeedLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // locationManager
    var locationManager: CLLocationManager?
    
    // map camera
    var mapCamera: MKMapCamera?
    
    // distance
    var distance: Double?
    
    // last location
    var lastLocation:CLLocationCoordinate2D?
    
    // timer to track runtime
    var timer: NSTimer?
    
    // var to hold seconds
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapview.delegate = self
        self.mapview.showsUserLocation = true
        initializeCoreLocation()
        distance = 0.0
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    func initializeCoreLocation(){
        if self.locationManager == nil{
            self.locationManager = CLLocationManager()
        }
        self.locationManager!.delegate = self
        self.locationManager!.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            //self.locationManager!.distanceFilter = 1
            self.locationManager!.startUpdatingLocation()
        }
    }
    
    // calculate distance
    func calculateDistance(oldLocation: CLLocation, newLocation: CLLocation){
        let newLat = (newLocation.coordinate.latitude * M_PI) / 180
        let newLng = (newLocation.coordinate.longitude * M_PI) / 180
        let oldLat = (oldLocation.coordinate.latitude * M_PI) / 180
        var oldLng = (oldLocation.coordinate.longitude * M_PI) / 180
        
        let R: Double = 3963
        let dLat = oldLat - newLat
        let dLng = oldLng - newLng
        
        let a = (sin(dLat / 2) * sin(dLat / 2)) + (cos(newLat) * cos(oldLat) * sin(dLng / 2) * sin(dLng / 2))
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let d = R * c
        self.distance! += d
        self.distanceLabel.text = String(format: "%.2f miles", self.distance!)
    }
    
    // calculate speed
    func calculateSpeed(newLocation: CLLocation){
        var currSpeed = newLocation.speed * 2.24
        if currSpeed <= 0.0 {
            if (timer != nil){
                timer?.invalidate()
            }
        }else{
            if timer == nil || timer?.valid == false{
                timer = NSTimer(timeInterval: 1, target: self, selector: "timeIncrement", userInfo: nil, repeats: true)
                NSRunLoop.currentRunLoop().addTimer(timer!, forMode: NSDefaultRunLoopMode)
            }
        }
        self.currentSpeedLabel.text = String(format: "%.2f miles per hour", currSpeed)
    }
    
    // add line
    func addTraveledPath(oldLocation: CLLocation, newLocation:CLLocation){
        if lastLocation != nil{
            var coordinates = [lastLocation!, newLocation.coordinate]
            let polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
            self.mapview.addOverlay(polyline)
        }
        lastLocation = newLocation.coordinate
    }
    
    // timer ticker
    func timeIncrement(){
        self.seconds++
        var remainingSeconds = seconds
        let hour = remainingSeconds / 3600
        remainingSeconds = remainingSeconds - hour * 3600
        let minute = remainingSeconds / 60
        remainingSeconds = remainingSeconds - minute * 60
        self.timeLabel.text = String(format: "%02i:%02i:%02i", hour, minute, remainingSeconds)
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline{
            var polylineRenderer = MKPolylineRenderer(overlay: overlay) as MKPolylineRenderer
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
        return nil
    }
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        self.calculateSpeed(newLocation)
        //self.mapview.setRegion(MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 20, 20), animated: true)
        if oldLocation != nil && newLocation != nil{
            calculateDistance(oldLocation, newLocation: newLocation)
            self.addTraveledPath(oldLocation, newLocation: newLocation)
            self.mapCamera = MKMapCamera(lookingAtCenterCoordinate: newLocation.coordinate, fromEyeCoordinate: CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude  + 0.010, longitude: newLocation.coordinate.longitude + 0.010), eyeAltitude: 10)
            self.mapCamera?.heading = newLocation.course
            self.mapview.camera = self.mapCamera!
            println("old altitude: \(oldLocation.altitude)")
            println("new altitude: \(newLocation.altitude)")
        }
    }
}
