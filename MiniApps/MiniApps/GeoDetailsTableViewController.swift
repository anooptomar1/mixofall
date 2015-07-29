//
//  GeoDetailsTableViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit


class GeoDetailsTableViewController: UITableViewController {

    var geofences = [Geofence]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        loadAllGeofences()
    }

    
    func loadAllGeofences(){
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey){
            for savedItem in savedItems{
                if let geofence = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Geofence{
                    geofences.append(geofence)
                }
            }
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geofences.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        var geofence = geofences[indexPath.row]
        var eventTypeString = (geofence.eventType == EventType.onEntry) ? "On Entry" : "On Exit"
        cell.textLabel?.text = geofence.note
        cell.detailTextLabel?.text = "Radius: \(geofence.radius)m \(eventTypeString)"
        return cell
    }

}
