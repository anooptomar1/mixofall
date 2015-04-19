//
//  ViewController.swift
//  MapkitApp
//
//  Created by Anoop tomar on 4/16/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var second: Int = 0
    var distance: Float = 0.0
    var locationManager: CLLocationManager?
    var locations = [CLLocation]()
    var timer: NSTimer?
    let metersInMile:Float = 1609.344;
  
    @IBOutlet weak var mapview: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapview.delegate = self
        UIApplication.sharedApplication().idleTimerDisabled = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    func eachSecond(){
        self.second++
        self.timeLabel.text = stringifyTime(second, longFormat: false)
        self.distanceLabel.text = stringifyDistance(distance)
        self.paceLabel.text = stringifyAvgPace(self.distance, seconds: self.second)
        if(self.locations.count == 2){
            loadMap()
        }
    }
    
    func startLocationUpdate(){
        if self.locationManager == nil{
            self.locationManager = CLLocationManager()
        }
        locationManager!.requestAlwaysAuthorization()
        self.locationManager!.delegate = self
        self.locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager!.activityType = CLActivityType.Fitness
        self.locationManager!.distanceFilter = 10
        self.locationManager!.startUpdatingLocation()
    }
    
    func stringifyTime(seconds: Int, longFormat: Bool) -> String{
        var remainindSec = seconds
        var hour = remainindSec / 3600
        remainindSec = remainindSec - hour * 3600
        var minute = remainindSec / 60
        remainindSec = remainindSec - minute * 60
        
        if longFormat{
            if hour > 0{
                return "\(hour)hr \(minute)min \(remainindSec)sec"
            }else if minute > 0{
                return "\(minute)min \(remainindSec)sec"
            }else{
                return "\(remainindSec)sec"
            }
        }else{
            if hour > 0{
                return "\(hour):\(minute):\(remainindSec)"
            }else if minute > 0 {
                return "\(minute):\(remainindSec)"
            }else{
                return "00:\(remainindSec)"
            }
        }
    }
    
    func stringifyDistance(distance: Float) -> String{
        return "\(distance / metersInMile)"
    }
    
    func stringifyAvgPace(meters: Float, seconds: Int) -> String{
        if seconds == 0 || meters == 0{
            return "0"
        }
        
        var avgPaceSecMeter:Float = Float(seconds) / meters
        
        var paceMin = (avgPaceSecMeter * metersInMile) / 60
        var paceSec = (avgPaceSecMeter * metersInMile) - (paceMin * 60)
        
        return "\(paceMin):\(paceSec)"
    }
    
    func loadMap(){
        self.mapview.region = mapRegion()
        self.mapview.addOverlay(self.polyline())
        self.mapview.showsUserLocation = true
    }
    
    func polyline() -> MKPolyline{
        var cords = [CLLocationCoordinate2D]()
        for i in 0..<self.locations.count{
            var location = self.locations[i]
            cords.append(CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude))
        }
        return MKPolyline(coordinates: &cords, count: self.locations.count)
    }
    
    func mapRegion() -> MKCoordinateRegion{
        var region = MKCoordinateRegion()
        var initLocation = self.locations.first
        var minLat = Float(initLocation!.coordinate.latitude)
        var minLng = Float(initLocation!.coordinate.longitude)
        var maxLat = Float(initLocation!.coordinate.latitude)
        var maxLng = Float(initLocation!.coordinate.longitude)
        
        for location in self.locations{
            if Float(location.coordinate.latitude) < minLat{
                minLat = Float(location.coordinate.latitude)
            }
            if Float(location.coordinate.longitude) < minLng{
                minLng = Float(location.coordinate.longitude)
            }
            if Float(location.coordinate.latitude) > maxLat{
                maxLat = Float(location.coordinate.latitude)
            }
            if Float(location.coordinate.longitude) > maxLng{
                maxLng = Float(location.coordinate.longitude)
            }
        }
        
        region.center.latitude = CLLocationDegrees((minLat + maxLat) / 2.0)
        region.center.longitude = CLLocationDegrees((minLng + maxLng) / 2.0)
        
        region.span.latitudeDelta = CLLocationDegrees((maxLat - minLat) * 2.0)
        region.span.longitudeDelta = CLLocationDegrees((maxLng - minLng) * 2.0)
        
        return region
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }
    
    @IBAction func onStart(sender: UIButton) {
        self.distance = 0.0
        self.second = 0
        self.locations.removeAll(keepCapacity: false)
        self.timer = NSTimer(timeInterval: 1, target: self, selector: "eachSecond", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
        self.startLocationUpdate()
    }
    
    @IBAction func onStop(sender: UIButton) {
        timer?.invalidate()
        locationManager?.stopUpdatingLocation()
    }
}

extension ViewController: MKMapViewDelegate{
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        if overlay is MKPolyline{
            var polyline = overlay as! MKPolyline
            var aRenderer = MKPolylineRenderer(polyline: polyline)
            aRenderer.strokeColor = UIColor(red: 54/255.0, green: 233/255.0, blue: 255/255.0, alpha: 0.8)
            aRenderer.lineWidth = 3
            return aRenderer
        }
        return nil
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        for location in locations as! [CLLocation]{
            
            var eventDate = location.timestamp
            
            var howRecent = eventDate.timeIntervalSinceNow
            
            if abs(howRecent) < 10.0 && location.horizontalAccuracy < 20{
                if self.locations.count > 0{
                    self.distance = Float(location.distanceFromLocation(self.locations.last))
                    
                    var cords: [CLLocationCoordinate2D] = [self.locations.last!.coordinate, location.coordinate]
                    var region = MKCoordinateRegionMakeWithDistance(location.coordinate, 500, 500)
                    self.mapview.setRegion(region, animated: true)
                    self.mapview.addOverlay(MKPolyline(coordinates: &cords, count: 2))
                }
                self.locations.append(location)
            }
        }
    }
}

