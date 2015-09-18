//
//  Geofence.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class Geofence: NSObject, NSCoding, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    var identifier: String
    var note: String
    var eventType: EventType
    
    var title:String?{
        if note.isEmpty{
            return "None"
        }
        return note
    }
    
    var subtitle: String?{
        let eventTypeString = (eventType == EventType.onEntry) ? "On Entry" : "On Exit"
        return "Radius:\(radius)m - \(eventTypeString)"
    }
    
    init(coord: CLLocationCoordinate2D, radi: CLLocationDistance, id: String, notes: String, eventT: EventType){
        self.coordinate = coord
        self.radius = radi
        self.identifier = id
        self.note = notes
        self.eventType = eventT
    }
    
    required init?(coder decoder: NSCoder) {
        let latitude = decoder.decodeDoubleForKey(kGeofenceLatitudeKey)
        let longitude = decoder.decodeDoubleForKey(kGeofenceLongitudeKey)
        coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        radius = decoder.decodeDoubleForKey(kGeofenceRadiusKey)
        identifier = decoder.decodeObjectForKey(kGeofenceIdentifierKey) as! String
        note = decoder.decodeObjectForKey(kGeofenceNoteKey) as! String
        eventType = EventType(rawValue: decoder.decodeIntegerForKey(kGeofenceEventTypeKey))!
    }
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeDouble(coordinate.latitude, forKey: kGeofenceLatitudeKey)
        coder.encodeDouble(coordinate.longitude, forKey: kGeofenceLongitudeKey)
        coder.encodeDouble(radius, forKey: kGeofenceRadiusKey)
        coder.encodeObject(identifier, forKey: kGeofenceIdentifierKey)
        coder.encodeObject(note, forKey: kGeofenceNoteKey)
        coder.encodeInteger(eventType.rawValue, forKey: kGeofenceEventTypeKey)
    }
}