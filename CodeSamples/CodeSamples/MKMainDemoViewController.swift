
//  MKMainDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/6/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MKMainDemoViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //var zoomed = false
    
    var locationManager: CLLocationManager?
    
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        addSearchBar()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
    }

    @IBAction func onZoom(sender: UIBarButtonItem) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 2000, 2000)
        mapView.setRegion(region, animated: true)
        //zoomed = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
    }
    
    @IBAction func onMapType(sender: UIBarButtonItem){
        if mapView.mapType == MKMapType.Standard{
            mapView.mapType = MKMapType.Satellite
        }else{
            mapView.mapType = MKMapType.Standard
        }
    }
    
    func addSearchBar(){
        searchBar.barStyle = UIBarStyle.Default
        searchBar.autocapitalizationType = UITextAutocapitalizationType.Words
        searchBar.autocorrectionType = UITextAutocorrectionType.Yes
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
    }
    
    func performSearch(){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBar.text!
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler { (response: MKLocalSearchResponse!, error: NSError!) -> Void in
            if error != nil{
                println(error.localizedDescription)
            }else if response.mapItems.count == 0{
                println("No match found")
            }else{
                for item in response.mapItems as! [MKMapItem]{
                    var annotation = ATPinAnnotation(coord: item.placemark.coordinate, titls: item.name, subTitle: item.phoneNumber)
                   
                    self.mapView.addAnnotation(annotation)
                
                }
                self.zoomToFit()
            }
        }
        
        
    }
    
    func zoomToFit(){
        // zoom map to show all annotation pins
        // https://gist.github.com/andrewgleave/915374
        //        MKMapRect zoomRect = MKMapRectNull;
        //        for (id <MKAnnotation> annotation in mapView.annotations) {
        //            MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        //            MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        //            if (MKMapRectIsNull(zoomRect)) {
        //                zoomRect = pointRect;
        //            } else {
        //                zoomRect = MKMapRectUnion(zoomRect, pointRect);
        //            }
        //        }
        //        [mapView setVisibleMapRect:zoomRect animated:YES];
        // end map zoom
        
        var zoomRect = MKMapRectNull
        for annotation in mapView.annotations as! [MKAnnotation]{
            var annotationPoint = MKMapPointForCoordinate(annotation.coordinate)
            var pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0)
            if MKMapRectIsNull(zoomRect){
                zoomRect = pointRect
            }else{
                zoomRect = MKMapRectUnion(zoomRect, pointRect)
            }
        }
        //mapView.setVisibleMapRect(zoomRect, animated: true)
        mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
    }
    
    // move keyboard with keyboard 
    //http://stackoverflow.com/questions/1951826/move-up-uitoolbar
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "liftMainViewWhenKeyboardAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "returnMainViewWhenKeyboardDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func liftMainViewWhenKeyboardAppear(aNotification: NSNotification){
        var userInfo: NSDictionary = aNotification.userInfo!
        var animationDuration = NSTimeInterval()
        var animationCurve = UIViewAnimationCurve(rawValue: 0)
        var keyboardFrame = CGRect()
        
        userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.getValue(&animationCurve)
        userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.getValue(&animationDuration)
        userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)?.getValue(&keyboardFrame)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(animationCurve!)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - keyboardFrame.size.height)
        UIView.commitAnimations()
        //mapView.centerCoordinate = mapView.userLocation.coordinate
        //println("keyboard appeared")
    }
    
    func returnMainViewWhenKeyboardDisappear(aNotification: NSNotification){
        var userInfo: NSDictionary = aNotification.userInfo!
        var animationDuration = NSTimeInterval()
        var animationCurve = UIViewAnimationCurve(rawValue: 0)
        var keyboardFrame = CGRect()
        
        userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.getValue(&animationCurve)
        userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.getValue(&animationDuration)
        userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)?.getValue(&keyboardFrame)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(animationCurve!)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height +  keyboardFrame.size.height)
        UIView.commitAnimations()
        //mapView.centerCoordinate = mapView.userLocation.coordinate
       // println("keyboard disappeared")
    }
    
    // end move view with keyboard
    
    @IBAction func onCloseKeyboard(sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
    }
    
}


extension MKMainDemoViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        performSearch()
    }
}

extension MKMainDemoViewController: MKMapViewDelegate{
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var newAnnotationView: MKAnnotationView?
        if annotation is ATPinAnnotation{
            var atAnnotation = ATPinAnnotation(coord: annotation.coordinate, titls: annotation.title!, subTitle: annotation.subtitle!)
            var rightButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            rightButton.addTarget(nil, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
            newAnnotationView = atAnnotation.createAnnotationView(self.mapView, annotation: annotation, rightAcces: rightButton)
        }
        return newAnnotationView
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        var annotation = view.annotation
        
        if annotation is ATPinAnnotation{
            let request = MKDirectionsRequest()
            request.setSource(MKMapItem.mapItemForCurrentLocation())
            request.setDestination(MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate, addressDictionary: nil)))
            request.requestsAlternateRoutes = false
            
            let directions = MKDirections(request: request)
            directions.calculateDirectionsWithCompletionHandler({ (response: MKDirectionsResponse!, error: NSError!) -> Void in
                if error != nil{
                    println(error.localizedDescription)
                }else{
                    for route in response.routes as! [MKRoute]{
                        self.mapView.removeOverlays(mapView.overlays)
                        self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                        for step in route.steps{
                            println(step.instructions)
                        }
                    }
                    // set map zoom level to cover source and destination
                    var userLocationMapPoint = MKMapPointForCoordinate(mapView.userLocation.coordinate)
                    var userRect = MKMapRectMake(userLocationMapPoint.x, userLocationMapPoint.y, 0, 0)
                    var pointLocationMapPoint = MKMapPointForCoordinate(annotation.coordinate)
                    var pointRect = MKMapRectMake(pointLocationMapPoint.x, pointLocationMapPoint.y, 0, 0)
                    self.mapView.setVisibleMapRect(MKMapRectUnion(userRect, pointRect), edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), animated: true)
                }
            })
        }
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.purpleColor()
        renderer.lineWidth = 5.0
        return renderer
    }
}
