//
//  CADViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/14/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CADViewController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    
    var l: CALayer{
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfilePic()
        //setUpLayer()
    }
    
    func setUpProfilePic(){
        l.contents = UIImage(named: "avatar")?.CGImage
        //l.contentsGravity = kCAGravityCenter
        //l.magnificationFilter = kCAFilterLinear
        l.geometryFlipped = false
        l.opacity = 1.0
        l.hidden = false
        l.masksToBounds = false
        l.cornerRadius = 100.0
        l.borderWidth = 12.0
        l.borderColor = UIColor.lightGrayColor().CGColor
        l.shadowOffset = CGSize(width: 0, height: 3)
        l.shadowOpacity = 0.75
        l.shadowRadius = 3.0
        l.masksToBounds = true
        l.shouldRasterize = true
    }

    func setUpLayer(){
        l.backgroundColor = UIColor.blueColor().CGColor
        l.borderWidth = 10.0
        l.borderColor = UIColor.redColor().CGColor
        l.shadowOpacity = 0.7
        l.shadowRadius = 10.0
        l.contents = UIImage(named: "star")?.CGImage
        l.contentsGravity = kCAGravityCenter
        l.magnificationFilter = kCAFilterLinear
        l.masksToBounds = false
    }
    
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        l.shadowOpacity = l.shadowOpacity == 0.7 ? 0.0 : 0.7
    }
    
    @IBAction func onPinch(sender: UIPinchGestureRecognizer) {
        let offset: CGFloat = sender.scale < 1 ? 10.0 : -10.0
        let oldFrame = l.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y + offset)
        let newSize = CGSize(width: oldFrame.width + (offset *  -2.0), height: oldFrame.height + (offset * -2.0))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        if newFrame.width >= 100.0 && newFrame.width <= 300{
            l.borderWidth -= offset
            l.cornerRadius += (offset / 2.0)
            l.frame = newFrame
        }
    }
    
}
