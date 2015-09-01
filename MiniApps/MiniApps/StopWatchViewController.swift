//
//  StopWatchViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    var secCounter = 0
    var minCounter = 0
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.text = "00:00"
    }

    func ticked(){
        if secCounter >= 59{
            minCounter++
            secCounter = 0
        }
        secCounter++
        counterLabel.text = String(format: "%02d:%02d", arguments: [minCounter,secCounter])
    }
    
    @IBAction func onPlay(sender: UIBarButtonItem) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "ticked", userInfo: nil, repeats: true)
    }
    @IBAction func onPause(sender: UIBarButtonItem) {
        timer.invalidate()
    }
    @IBAction func onRefresh(sender: UIBarButtonItem) {
        timer.invalidate()
        secCounter = 0
        counterLabel.text = "00:00"
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
