//
//  ViewController.swift
//  transitionDemo
//
//  Created by Anoop tomar on 8/4/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftTop: UIView!
    @IBOutlet weak var rightTop: UIView!
    @IBOutlet weak var bottomLeft: UIView!
    @IBOutlet weak var bottomRight: UIView!
    
    // clock hands
    @IBOutlet weak var hour_hand: UIImageView!
    @IBOutlet weak var minute_hand: UIImageView!
    @IBOutlet weak var seconds_hand: UIImageView!
    @IBOutlet weak var clock_face: UIImageView!
    
    var timer: NSTimer?
    
    
    @IBOutlet weak var layerView: UIView!
    var transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewHostedLayer()
        addSpriteLayers()
        clockTicking()
        positionColorRadius()
        shadowBottomLeft()
        maskLayer()
    }
    
    func maskLayer(){
        let maskLayer = CALayer()
        maskLayer.frame = self.bottomRight.bounds
        maskLayer.contents = UIImage(named: "clock_face")!.CGImage
        self.bottomRight.layer.mask = maskLayer
    }
    
    func shadowBottomLeft(){
        self.bottomLeft.layer.shadowOpacity = 0.5
        var squarePath = CGPathCreateMutable()
        CGPathAddRect(squarePath, nil, self.bottomLeft.bounds)
        self.bottomLeft.layer.shadowPath = squarePath

    }
    
    func positionColorRadius(){
        self.leftTop.layer.zPosition = 1
        self.rightTop.layer.zPosition = 1
        self.leftTop.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.75)
        self.rightTop.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.75)
        self.bottomRight.layer.cornerRadius = 10
        self.bottomRight.clipsToBounds = true
        self.bottomRight.layer.borderWidth = 5.0
        self.bottomRight.layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func clockTicking(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "tick", userInfo: nil, repeats: true)
        self.tick()
        self.hour_hand.layer.anchorPoint = CGPointMake(0.9,0.9)
        self.minute_hand.layer.anchorPoint = CGPointMake(1,1)
        self.seconds_hand.layer.anchorPoint = CGPointMake(0.5,0.9)
        self.seconds_hand.tintColor = UIColor.redColor()
        self.clock_face.layer.shadowOpacity = 0.75
        self.clock_face.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
    }
   
    func tick(){
        var calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        var units = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond
        var components = calendar!.components(units, fromDate: NSDate())
        
        var hourAngle = ((CGFloat(components.hour) + (CGFloat(components.minute) / 60.0)) / CGFloat(12.0)) * CGFloat(M_PI) * CGFloat(2.0)
        var minAngle = (CGFloat(components.minute) / CGFloat(60.0)) * CGFloat(M_PI) * CGFloat(2.0)
        var secondsAngle = (CGFloat(components.second) / CGFloat(60.0)) * CGFloat(M_PI) * CGFloat(2.0)
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.hour_hand.transform = CGAffineTransformMakeRotation(hourAngle)
        })
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            self.minute_hand.transform = CGAffineTransformMakeRotation(minAngle)
        })
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.seconds_hand.transform = CGAffineTransformMakeRotation(secondsAngle)
        })
    }
    

    func addSpriteLayers(){
        var image = UIImage(named: "sprite")
        addSpriteLayerToView(leftTop, rect: CGRectMake(0, -0.025, 1.0, 0.34), image: image!)
        addSpriteLayerToView(rightTop, rect: CGRectMake(0, 0.34, 1.0, 0.34), image: image!)
        addSpriteLayerToView(bottomLeft, rect: CGRectMake(0, 0.68, 1.0, 0.34), image: image!)
        addSpriteLayerToView(bottomRight, rect: CGRectMake(0, 0, 1, 1), image: UIImage(named: "Photo")!)
    }
    
    func addSpriteLayerToView(view: UIView, rect:CGRect, image: UIImage){
        view.layer.contents = image.CGImage
        view.layer.contentsGravity =  kCAGravityResizeAspect
        view.layer.contentsRect = rect
        view.layer.contentsScale = UIScreen.mainScreen().scale
        //view.layer.contentsCenter = CGRectMake(0, 0, 0.25, 0.25)
    }
    
    func addNewHostedLayer(){
        var blueLayer = CALayer()
        blueLayer.frame = CGRectMake(37.5, 37.5, 75, 75.0)
        //blueLayer.backgroundColor = UIColor.blueColor().CGColor
        blueLayer.delegate = self
        blueLayer.contentsScale = UIScreen.mainScreen().scale
        
        self.layerView.layer.addSublayer(blueLayer)
        blueLayer.setNeedsDisplay()
    }
    
    override func drawLayer(layer: CALayer!, inContext ctx: CGContext!) {
        CGContextSetLineWidth(ctx, 10.0)
        CGContextSetStrokeColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextStrokeEllipseInRect(ctx, CGRectMake(layer.bounds.origin.x + 5, layer.bounds.origin.y + 5, layer.bounds.width - 10, layer.bounds.height - 10))
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! UIViewController
        vc.transitioningDelegate = self.transitionManager
    }

}

