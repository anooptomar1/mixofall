//
//  PhotoMapAnnotation.swift
//  mixofall
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MapKit

class PhotoMapAnnotation: NSObject{
    let latitude: Double
    let longitude: Double
    
    init(lat: Double, lng: Double){
        self.latitude = lat
        self.longitude = lng
    }
}

extension PhotoMapAnnotation: MKAnnotation{
    var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    var title: String{
        return "Picture"
    }
    
//    var subtitle: String{
//        return "Fremont, CA"
//    }
}