//
//  CurrentWeatherViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.layer.cornerRadius = 10
        self.containerView.clipsToBounds = true
    }

}
