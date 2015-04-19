//
//  MyAnnotation.swift
//  MapkitApp
//
//  Created by Anoop tomar on 4/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import MapKit

class MyAnnotation: NSObject, MKAnnotation{
    
    var currentLocation = CLLocationCoordinate2DMake(37.810000, -122.477450)
    
    var coordinate: CLLocationCoordinate2D{
        get{
            return currentLocation
        }
        set{
            currentLocation = newValue
        }
    }
    
    var title: String{
        get{
            return "Golden Gate Bridge"
        }
    }
    
    var subtitle: String{
        get{
            return "Opened: May 27, 1937"
        }
    }
    
    func createAnnotationView(mapview: MKMapView, annotation: MKAnnotation) -> MKAnnotationView{
        var returnAnnotationView = mapview.dequeueReusableAnnotationViewWithIdentifier(NSStringFromClass(MyAnnotation)) as? MKPinAnnotationView
        if returnAnnotationView == nil{
            returnAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: NSStringFromClass(MyAnnotation))
            returnAnnotationView!.pinColor = MKPinAnnotationColor.Purple
            returnAnnotationView!.animatesDrop = true
            returnAnnotationView?.canShowCallout = true
        }
        
        return returnAnnotationView!
    }
}
