//
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
       // mapView.delegate = self
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
                    var annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
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

//extension MKMainDemoViewController: MKMapViewDelegate{
//    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
//        if zoomed{
//            mapView.centerCoordinate = userLocation.location.coordinate
//        }
//    }
//
//}
