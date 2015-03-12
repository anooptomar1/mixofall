//
//  LocationViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit
import MapKit

protocol LocationViewControllerDelegate: class{
    func didSetLocation(location:CLLocationCoordinate2D)
}

class LocationViewController: UIViewController {

    weak var delegate: LocationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onButtonClick(sender: AnyObject) {
        self.delegate?.didSetLocation(CLLocationCoordinate2D(latitude: 37.5413311, longitude: -122.303767))
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
