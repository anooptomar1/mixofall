//
//  MapItemMainViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreLocation
import AddressBook
import MapKit

class MapItemMainViewController: UIViewController {

    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    var coords: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func GetDirections(sender: UIButton) {
    
        let geoCoder = CLGeocoder()
        let addressString = "\(street.text) \(city.text) \(state.text) \(zipcode.text)"
        geoCoder.geocodeAddressString(addressString, completionHandler: { (placemarks: [AnyObject]!, error: NSError!) -> Void in
            if error != nil{
                println("Geocode failed with error: \(error.localizedDescription)")
            }else{
                let placemark = placemarks[0] as! CLPlacemark
                let location = placemark.location
                self.coords = location.coordinate
                println("\(self.coords!.latitude), \(self.coords!.longitude)")
                self.showMap()
            }
        })
        
    }
    
    func showMap(){
        let addressDict = [kABPersonAddressStreetKey as NSString: "34173 Audrey Ct.",
            kABPersonAddressCityKey: "Fremont",
            kABPersonAddressStateKey: "California",
            kABPersonAddressZIPKey: "94555"
        ]
        
        let place = MKPlacemark(coordinate: self.coords!, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: place)
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMapsWithLaunchOptions(options)
    }
    
}
