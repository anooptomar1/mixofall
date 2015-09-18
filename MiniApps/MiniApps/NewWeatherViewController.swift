//
//  NewWeatherViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

protocol NewWeatherViewControllerDelegate: class{
    func didSaveNewLocation(newWeather: NewWeatherViewController, city: weatherCity)
}

class NewWeatherViewController: UIViewController {

    weak var delegate: NewWeatherViewControllerDelegate?
    var sourceVC: WeatherLocationsViewController?
    
    @IBOutlet weak var zipText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onSave(sender: UIBarButtonItem) {
        
        var url = NSURL(string: "http://maps.googleapis.com/maps/api/geocode/json?address=\(zipText.text!)")
        var session = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            if error == nil{
                var dataDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.didSaveNewLocation(self, city: weatherCity.convertJSONToWeatherCity(dataDictionary))
                    self.navigationController?.popToViewController(self.sourceVC!, animated: true)
                })
            }
        })
        session.resume()
    }

}
