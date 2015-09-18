//
//  CPViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CPViewController: UIViewController {

    let ovalStartAngle = CGFloat(140 * M_PI/180)
    let ovalEndAngle = CGFloat(40 * M_PI/180)
    let ovalRect = CGRectMake(100, 100, 125, 125)
    
    @IBOutlet weak var circularView: progressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ovalPath = UIBezierPath()
        ovalPath.addArcWithCenter(CGPointMake(CGRectGetMidX(ovalRect), CGRectGetMidY(ovalRect)), radius: CGRectGetWidth(ovalRect)/2, startAngle: ovalStartAngle, endAngle: ovalEndAngle, clockwise: true)
        
        let progressLine = CAShapeLayer()
        progressLine.path = ovalPath.CGPath
        progressLine.strokeColor = UIColor.blueColor().CGColor
        progressLine.fillColor = UIColor.whiteColor().CGColor
        progressLine.lineWidth = 10.0
        progressLine.lineCap = kCALineCapRound
        self.view.layer.addSublayer(progressLine)
        
        let label = UILabel(frame: CGRectMake(ovalRect.midX/2, ovalRect.midY/2, 50, 50))
        label.text = "70"
        label.font = UIFont(name: "chalkboard", size: 16)
        label.textColor = UIColor.blackColor()
        
        self.view.addSubview(label)
        
        let animationStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animationStrokeEnd.duration = 3.0
        animationStrokeEnd.fromValue = 0.0
        animationStrokeEnd.toValue = 1.0
        
        progressLine.addAnimation(animationStrokeEnd, forKey: "stroke path drawn")
        
        circularView.animateProgressView()
    }

    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
