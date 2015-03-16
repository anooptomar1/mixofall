//
//  WeatherViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/14/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    var weatherSettings: WeatherSettings!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        addWeatherSettings()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addWeatherSettings(){
        weatherSettings = NSBundle.mainBundle().loadNibNamed("WeatherSettings", owner: self, options: nil).last as WeatherSettings
        weatherSettings.frame = CGRectMake(0, self.view.frame.height - 100, self.view.frame.width, self.view.frame.height)
        
        self.view.addSubview(weatherSettings)
        weatherSettings.setup()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
   
}
