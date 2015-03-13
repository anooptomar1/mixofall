//
//  LocationViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/12/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol LocationViewControllerDelegate: class{
    func didSetLocation(locationViewController: LocationViewController, location: PhotoMapAnnotation)
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
    
    @IBAction func onButtonPress(sender: UIButton) {
        self.delegate?.didSetLocation(self, location: PhotoMapAnnotation(lat: 37.359974624688, lng: -122.026310127546))
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
