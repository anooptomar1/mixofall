//
//  DetailViewController.swift
//  taskList
//
//  Created by Anoop tomar on 3/2/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!

    @IBOutlet weak var locationText: UITextField!

    var detailItem: TaskList? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: TaskList = self.detailItem {
            if let name = self.nameText {
                name.text = detail._name
            }
            if let location = self.locationText{
                location.text = detail._location
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    @IBAction func changeDetails(sender: AnyObject!){
        if sender === nameText{
            detailItem?._name = nameText.text
        }
        if sender === locationText{
            detailItem?._location = locationText.text
        }
    }

}

