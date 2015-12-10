//
//  RestaurantMapViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/4/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class RestaurantMapViewController: UIViewController {

    var restaurant: Restaurant?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        if let rest = restaurant{
            title = rest.name
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(rest.location, completionHandler: { (placemark: [CLPlacemark]?, error: NSError?) -> Void in
                if let coordinate = placemark![0].location?.coordinate{
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant!.name
                    annotation.subtitle = self.restaurant!.type
                    annotation.coordinate = coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RestaurantMapViewController: MKMapViewDelegate{

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.image = UIImage(data: restaurant!.image)
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.orangeColor()
        return annotationView
    }
    
}
