//
//  WTViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WTViewController: UIViewController {

    @IBOutlet weak var counterV: CounterVIew!
    @IBOutlet weak var counterL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func OnClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func onPlus(sender: PushButtonView) {
        if counterV.counter < numberOfGlasses{
            counterV.counter++
            counterLabel()
        }
    }
    
    @IBAction func onMinus(sender: PushButtonView) {
        if counterV.counter > 0{
            counterV.counter--
            counterLabel()
        }
    }
    
    func counterLabel(){
        counterL.text = String(counterV.counter)
    }
    
}
