//
//  StopWatchViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/7/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class StopWatchViewController: UIViewController {

    @IBOutlet weak var timerDisplayLabel: UILabel!
    
    var timer = NSTimer()
    
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timerDisplayLabel.alpha = 0.0
    }
    
    func result(){
        var originalCenterY = self.timerDisplayLabel.center.y
        
        UIView.animateWithDuration(0.6, animations: { () -> Void in
                //self.timerDisplayLabel.center.y = self.timerDisplayLabel.center.y - self.view.bounds.size.height / 4
                self.timerDisplayLabel.alpha = 0.0
            }, completion: {(Bool) -> Void in
                //self.timerDisplayLabel.center.y = originalCenterY

        })
       
        UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.timerDisplayLabel.center.y = self.timerDisplayLabel.center.y + self.view.bounds.size.height / 4
                self.timerDisplayLabel.alpha = 1.0
                self.timerDisplayLabel.text = "\(++self.count)"
            }, completion: {(Bool) -> Void in
                self.timerDisplayLabel.center.y = originalCenterY
        })
        
    }
    @IBAction func onPlayButton(sender: UIBarButtonItem) {
        timer.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "result", userInfo: nil, repeats: true)
    }

    @IBAction func onStopButton(sender: UIBarButtonItem) {
        timer.invalidate()
        count = 0
    }
    @IBAction func onPauseButton(sender: UIBarButtonItem) {
        timer.invalidate()
    }
}
