//
//  CAScrollViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/16/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CAScrollViewController: UIViewController {

    @IBOutlet weak var image: ScrollView!
    @IBOutlet weak var horizontalSwitch: UISwitch!
    @IBOutlet weak var verticalSwitch: UISwitch!
    
    var scrollingViewLayer: CAScrollLayer{
        return image.layer as! CAScrollLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollingViewLayer.scrollMode = kCAScrollBoth
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        var newPoint = image.bounds.origin
        newPoint.x -= sender.translationInView(image).x
        newPoint.y -= sender.translationInView(image).y
        sender.setTranslation(CGPointZero, inView: image)
        scrollingViewLayer.scrollToPoint(newPoint)
        
        UIView.animateWithDuration(2, delay: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.scrollingViewLayer.scrollToPoint(CGPointZero)
        }, completion: nil)
    }
    

    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func OnSliderChange(sender: UISwitch) {
        switch (horizontalSwitch.on, verticalSwitch.on){
        case (true, true):
            scrollingViewLayer.scrollMode = kCAScrollBoth
        case (true, false):
            scrollingViewLayer.scrollMode = kCAScrollHorizontally
        case (false, true):
            scrollingViewLayer.scrollMode = kCAScrollVertically
        default:
            scrollingViewLayer.scrollMode = kCAScrollNone
        }
    }
    
    
}
