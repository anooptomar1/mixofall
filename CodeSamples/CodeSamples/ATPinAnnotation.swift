//
//  ATPinAnnotation.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/6/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit

class ATPinAnnotation: NSObject, MKAnnotation {
    private var currentLocation: CLLocationCoordinate2D?
    private var aTitle: String?
    private var aSubTitle: String?
    
    var coordinate: CLLocationCoordinate2D{
        get{
            return currentLocation!
        }
        set{
            currentLocation = newValue
        }
    }
    
    var title: String{
        get{
            return aTitle!
        }
        set{
            aTitle = newValue
        }
    }
    
    var subtitle: String{
        get{
            return aSubTitle!
        }
        set{
            aSubTitle = newValue
        }
    }
    
    init(coord: CLLocationCoordinate2D, titls: String, subTitle: String){
        super.init()
        self.coordinate = coord
        self.title = titls
        self.subtitle = subTitle
    }
    
    func createAnnotationView(mapview: MKMapView, annotation: MKAnnotation, rightAcces: UIView) -> MKAnnotationView{
        var annotationView = mapview.dequeueReusableAnnotationViewWithIdentifier(NSStringFromClass(ATPinAnnotation)) as? MKPinAnnotationView
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: NSStringFromClass(ATPinAnnotation))
            annotationView?.pinColor = MKPinAnnotationColor.Green
            annotationView?.animatesDrop = true
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = rightAcces
        }
        return annotationView!
    }
}
