//
//  TouchDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/17/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TouchDemoViewController: UIViewController {

    @IBOutlet weak var mehodLabel: UILabel!
    @IBOutlet weak var touchesLabel: UILabel!
    @IBOutlet weak var tabLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        let point = touch.locationInView(self.view)
        
        mehodLabel.text = "touches began at x:\(point.x), y:\(point.y)"
        touchesLabel.text = "\(touchCount) touches"
        tabLabel.text = "\(tapCount) taps"
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        let point = touch.locationInView(self.view)
        
        mehodLabel.text = "touchs moved at x:\(point.x), y:\(point.y)"
        touchesLabel.text = "\(touchCount) touches"
        tabLabel.text = "\(tapCount) taps"
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touchCount = touches.count
        let touch = touches.first as! UITouch
        let tapCount = touch.tapCount
        let point = touch.locationInView(self.view)
        
        mehodLabel.text = "touches ended at x:\(point.x), y:\(point.y)"
        touchesLabel.text = "\(touchCount) touches"
        tabLabel.text = "\(tapCount) taps"
    }
}
