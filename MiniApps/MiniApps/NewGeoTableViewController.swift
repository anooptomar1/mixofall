//
//  NewGeoTableViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol NewGeoTableViewControllerDelegate{
    func addNewGeofence(controller: NewGeoTableViewController,coordinates: CLLocationCoordinate2D, radius: CLLocationDistance, identifier: String, note: String, eventType:EventType)
}


class NewGeoTableViewController: UITableViewController {

    var sourceController: UIViewController?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var entryOn: UISegmentedControl!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusText: UITextField!
    @IBOutlet weak var noteText: UITextField!
    
    var locationManager = CLLocationManager()
    
    var delegate: NewGeoTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    @IBAction func onCancel(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onStep(sender: UIStepper) {
        radiusText.text = "\(sender.value)"
    }
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        let coordinates = mapView.centerCoordinate
        let radius = (radiusText.text as NSString?)!.doubleValue
        let identifier = NSUUID().UUIDString
        let notes = noteText.text
        let eventType = (entryOn.selectedSegmentIndex == 0) ? EventType.onEntry : EventType.onExit
        delegate?.addNewGeofence(self, coordinates: coordinates, radius: radius, identifier: identifier, note: notes!, eventType: eventType)
    }
    
    @IBAction func onEditChanged(sender: UITextField) {
        saveButton.enabled = (!radiusText.text!.isEmpty) && (!noteText.text!.isEmpty)
    }
}

extension NewGeoTableViewController: CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == CLAuthorizationStatus.AuthorizedAlways)
        mapView.userTrackingMode = MKUserTrackingMode.Follow
    }
}

extension NewGeoTableViewController: MKMapViewDelegate{
    
}
