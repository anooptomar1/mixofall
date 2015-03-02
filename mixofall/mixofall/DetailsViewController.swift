//
//  DetailsViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/1/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var myTask: MyList!
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var detailsText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = myTask.name
        detailsText.text = myTask.location
    }

}
