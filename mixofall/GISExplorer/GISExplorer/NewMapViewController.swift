//
//  NewMapViewController.swift
//  GISExplorer
//
//  Created by Anoop tomar on 4/26/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit

class NewMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // location manager var
    var locationManager: CLLocationManager?
    
    // temp flag
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        
        self.initializeLocationManager()
        self.addNavItem()
    }
    
    func addNavItem(){
        var mapTrack = MKUserTrackingBarButtonItem(mapView: self.mapView)
        self.navigationItem.leftBarButtonItem = mapTrack
    }
    
    func initializeLocationManager(){
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        
        if self.locationManager!.respondsToSelector("requestWhenInUseAuthorization"){
            self.locationManager!.requestWhenInUseAuthorization()
        }
        
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.startUpdatingLocation()
    }
    
    func coordinateRegionWithCenter(centerCoordinate: CLLocationCoordinate2D, radiusInMeters: CLLocationDistance) -> MKCoordinateRegion{
        
        var radiusInMapPoints:Double = radiusInMeters * MKMapPointsPerMeterAtLatitude(centerCoordinate.latitude)
        
        var radiusSquared = MKMapSize(width: radiusInMapPoints, height: radiusInMapPoints)
        var regionOrigin = MKMapPointForCoordinate(centerCoordinate)
        var regionRect = MKMapRect(origin: regionOrigin, size: radiusSquared)
        regionRect = MKMapRectOffset(regionRect, -radiusInMapPoints / 2, -radiusInMapPoints / 2)
        
        regionRect = MKMapRectIntersection(regionRect, MKMapRectWorld)
        
        var region = MKCoordinateRegionForMapRect(regionRect)
        return region
    }
}

extension NewMapViewController: MKMapViewDelegate{
    
}

extension NewMapViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
            if locations != nil && locations.count > 0{
                var newLocation: CLLocation = locations[0] as! CLLocation
                if flag{
                    var region = coordinateRegionWithCenter(newLocation.coordinate, radiusInMeters: 2500)
                    self.mapView.setRegion(region, animated: true)
                    self.mapView.setUserTrackingMode(MKUserTrackingMode.FollowWithHeading, animated: true)
                    
                }
                flag = false
        }
    }
}





















