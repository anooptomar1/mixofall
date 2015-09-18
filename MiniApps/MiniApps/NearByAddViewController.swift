//
//  NearByAddViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/8/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByAddViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var lngLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var mapVIew: MKMapView!
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVIew.delegate = self
        
        switch(CLLocationManager.authorizationStatus()){
        case CLAuthorizationStatus.AuthorizedAlways:
            initLocationManager()
        case CLAuthorizationStatus.AuthorizedWhenInUse:
            initLocationManager()
        case CLAuthorizationStatus.Denied:
            print("Authorization denied")
        case CLAuthorizationStatus.NotDetermined:
            print("Unable to determine auth status")
        case CLAuthorizationStatus.Restricted:
            print("Auth status restricted")
        }
        
        mapVIew.setUserTrackingMode(MKUserTrackingMode.Follow, animated: true)
        mapVIew.showsUserLocation = true
    }
    
    func initLocationManager(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager!.startUpdatingLocation()
        }
    }
    
    
    @IBAction func didPressDismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
        stopLocationUpdate()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let loc = locations.last as CLLocation?
        latLabel.text = "\(loc!.coordinate.latitude)"
        lngLabel.text = "\(loc!.coordinate.longitude)"
        headingLabel.text = "\(loc!.course)"
        speedLabel.text = "\(loc!.speed)"
        altitudeLabel.text = "\(loc!.altitude)"
        CLGeocoder().reverseGeocodeLocation(loc!, completionHandler: { (placemarks, error) -> Void in
            if error != nil{
                print("\(error!.localizedDescription)")
            }else{
                let place = CLPlacemark(placemark: (placemarks?.first as CLPlacemark?)!)
                let message = "\(place.name), \(place.thoroughfare), \(place.subThoroughfare), \(place.locality), \(place.subLocality), \(place.subAdministrativeArea), \(place.administrativeArea), \(place.postalCode)"
                self.addressLabel.text = message
            }
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        stopLocationUpdate()
    }
    
    func stopLocationUpdate(){
        if locationManager != nil{
            locationManager!.stopUpdatingLocation()
        }
    }
}
