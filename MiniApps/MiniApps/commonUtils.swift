//
//  commonUtils.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
import UIKit

let kGeofenceLatitudeKey = "latitude"
let kGeofenceLongitudeKey = "longitude"
let kGeofenceRadiusKey = "radius"
let kGeofenceIdentifierKey = "identifier"
let kGeofenceNoteKey = "note"
let kGeofenceEventTypeKey = "eventType"

let kSavedItemsKey = "savedItems"

let commonInset = 100

enum EventType: Int{
    case onEntry = 0
    case onExit = 1
}

func getMessageFromGeofence(identifier: String) -> String?{
    if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey){
        for savedItem in savedItems{
            if let geofence = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Geofence{
                if geofence.identifier == identifier{
                    return geofence.note
                }
            }
        }
    }
    return nil
}

func showLocalNotification(message: String){
    var notification = UILocalNotification()
    notification.alertBody = message
    notification.soundName = "Default"
    UIApplication.sharedApplication().presentLocalNotificationNow(notification)
}