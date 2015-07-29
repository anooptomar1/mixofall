//
//  GeoFViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class GeoFViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var geofences = [Geofence]()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        loadAllGeofences()
    }

    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addGeofence(geofense: Geofence){
        geofences.append(geofense)
        mapView.addAnnotation(geofense)
        addCircularOverlay(geofense)
    }
    
    func loadAllGeofences(){
        geofences = []
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey){
            for savedItem in savedItems{
                if let geofence = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Geofence{
                    addGeofence(geofence)
                }
            }
        }
    }
    
    func saveAllGeofences(){
        var items = NSMutableArray()
        for geofence in geofences{
            let item = NSKeyedArchiver.archivedDataWithRootObject(geofence)
            items.addObject(item)
        }
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: kSavedItemsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "newGeoSegue"{
            var destVC = (segue.destinationViewController as! UINavigationController).viewControllers.first as! NewGeoTableViewController
            destVC.delegate = self
        }
    }
    
    func addCircularOverlay(geofence: Geofence){
        mapView.addOverlay(MKCircle(centerCoordinate: geofence.coordinate, radius: geofence.radius))
        centerMaptoCoordinates()
    }
 
    func centerMaptoCoordinates(){
        // center map on all pin coordinates
        var zoomRect = MKMapRectNull
        for annotation in mapView.annotations{
            var annotationPoint = MKMapPointForCoordinate((annotation as? MKAnnotation)!.coordinate)
            var pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1)
            zoomRect = MKMapRectUnion(zoomRect, pointRect)
        }
        
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: CGFloat(commonInset), left: CGFloat(commonInset), bottom: CGFloat(commonInset), right: CGFloat(commonInset)), animated: true)
    }
    
    func startMonitoringForGeofence(geofence: Geofence){
        if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion){
            showLocalNotification("Geofencing is not supported on your device. Sorry :( ")
            return
        }
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways{
            showLocalNotification("Geofene is saved but please allow to access your location")
        }
        
        locationManager.startMonitoringForRegion(regionForGeofence(geofence))
        
    }
    
    func stopMonitoringForGeofence(geofence: Geofence){
    
        for region in locationManager.monitoredRegions{
            if let circularRegion = region as? CLCircularRegion{
                if circularRegion.identifier == geofence.identifier{
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
        
    }
    
    func regionForGeofence(geofence: Geofence) -> CLCircularRegion{
        var region = CLCircularRegion(center: geofence.coordinate, radius: geofence.radius, identifier: geofence.identifier)
        region.notifyOnEntry = (geofence.eventType == EventType.onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func removeGeofence(geofence: Geofence){
        if let index = find(geofences, geofence){
            geofences.removeAtIndex(index)
        }
        
        mapView.removeAnnotation(geofence)
        removeRadiusOverlayforGeofence(geofence)
    }
    
    func removeRadiusOverlayforGeofence(geofence: Geofence){
        if let overlays = mapView.overlays{
            for overlay in overlays{
                if let circleOverlay = overlay as? MKCircle{
                    var coord = circleOverlay.coordinate
                    if coord.latitude == geofence.coordinate.latitude && coord.longitude == geofence.coordinate.longitude && circleOverlay.radius == geofence.radius{
                        mapView.removeOverlay(circleOverlay)
                    }
                }
            }
        }
    }
}

// MARK: MKMapViewDelegate
extension GeoFViewController: MKMapViewDelegate{
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "myGeofence"
        if annotation is Geofence{
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            if annotationView == nil{
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.animatesDrop = true
                annotationView?.canShowCallout = true
                var removeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
                removeButton.frame = CGRectMake(0, 0, 23, 23)
                removeButton.setImage(UIImage(named: "delete")!, forState: UIControlState.Normal)
                annotationView?.leftCalloutAccessoryView = removeButton
            }else{
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKCircle{
            var circleRendrer = MKCircleRenderer(overlay: overlay)
            circleRendrer.lineWidth = 2.0
            circleRendrer.strokeColor = UIColor.blueColor()
            circleRendrer.fillColor = UIColor.redColor().colorWithAlphaComponent(0.4)
            return circleRendrer
        }
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var geofence = view.annotation as! Geofence
        stopMonitoringForGeofence(geofence)
        removeGeofence(geofence)
        saveAllGeofences()
    }
}

extension GeoFViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.mapView.showsUserLocation  = (status == CLAuthorizationStatus.AuthorizedAlways)
    }
}

extension GeoFViewController: NewGeoTableViewControllerDelegate{
    func addNewGeofence(controller: NewGeoTableViewController, coordinates: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType: EventType) {
        dismissViewControllerAnimated(true, completion: nil)
        
        let clampedRadius = (radius > locationManager.maximumRegionMonitoringDistance) ? locationManager.maximumRegionMonitoringDistance : radius
        let geofence = Geofence(coord: coordinates, radi: radius, id: identifier, notes: note, eventT: eventType)
        startMonitoringForGeofence(geofence)
        addGeofence(geofence)
        saveAllGeofences()
    }
}
