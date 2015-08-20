//
//  LEViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import CoreText

class LEViewController: UIViewController {
    
    var flag = true
    var cl: CALayer!
    var v: UIView!
    var label: UILabel!
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateCircle()
        //pulseAnimation()
        //easingOnView()
        //easingTest()
        //cometDial()
        //gradientDial()
        //self.reflectionLayer()
        //self.textLayer()
        //self.roundedButton()
        //self.addViewOne()
        //self.canvasExample()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func rotateCircle(){
        
        // init timer
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "tick", userInfo: nil, repeats: true)
        
        v = UIView(frame: CGRectMake(100, 100, 100, 100))
        //v.backgroundColor = UIColor.lightGrayColor()
        
        
        
        var path = UIBezierPath(arcCenter: CGPoint(x: v.bounds.size.width/2, y: v.bounds.size.height/2), radius: v.bounds.size.width/2+10, startAngle: 0, endAngle: CGFloat(M_PI), clockwise: true)
        
        cl = CAShapeLayer()
        (cl as! CAShapeLayer).path = path.CGPath
        (cl as! CAShapeLayer).strokeColor = UIColor.lightGrayColor().CGColor
        (cl as! CAShapeLayer).fillColor = UIColor.clearColor().CGColor
        (cl as! CAShapeLayer).lineWidth = 4
        (cl as! CAShapeLayer).frame = CGRectMake(0, 0, v.bounds.size.width, v.bounds.size.height)
        v.layer.addSublayer(cl as! CAShapeLayer)
  //      v.layer.insertSublayer(cl, atIndex: 0)
        
        v.layer.cornerRadius = v.bounds.size.width/2
        v.layer.backgroundColor = UIColor.blueColor().CGColor
        
        
        // rotation animation
        
        var animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.byValue = CGFloat(M_PI*2)
        animation.duration = 1
        animation.repeatCount = Float.infinity
        animation.removedOnCompletion = false
        (cl as! CAShapeLayer).addAnimation(animation, forKey: "circleRotate")
        
        self.view.addSubview(v)
        
        // add a label for time
        label = UILabel(frame: v.bounds)
        label.font = UIFont.systemFontOfSize(16)
        //label.text = "12:12:12"
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.whiteColor()
        v.addSubview(label)
    }
    
    func tick(){
        var calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        var units = NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond
        
        var components = calendar?.components(units, fromDate: NSDate())
        var hour = (components!.hour<10) ? "0\(components!.hour)" : "\(components!.hour)"
        var minute = components!.minute<10 ? "0\(components!.minute)" : "\(components!.minute)"
        var second = components!.second<10 ? "0\(components!.second)" : "\(components!.second)"
        label.text = "\(hour):\(minute):\(second)"
        
        var red = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        var green = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)
        var blue = CGFloat(arc4random_uniform(255)) / CGFloat(255.0)

        
        (cl as! CAShapeLayer).strokeColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0).CGColor
    }
    
    func pulseAnimation(){
        cl = CALayer()
        cl.frame = CGRectMake(100, 100, 200, 200)
        cl.backgroundColor = UIColor.blueColor().CGColor
        
        self.view.layer.addSublayer(cl)
    }
    
    func changeColor(){
        var animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 1.0
        animation.values = [UIColor.lightGrayColor().CGColor,
                            UIColor.blueColor().CGColor,
                            UIColor.lightGrayColor().CGColor,
                            UIColor.blueColor().CGColor,
                            UIColor.lightGrayColor().CGColor]
        
        var timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.timingFunctions = [timingFunction, timingFunction, timingFunction, timingFunction]
        cl.addAnimation(animation, forKey: "backAnimation")
    }
    
    func easingOnView(){
        v = UIView(frame: CGRectMake(0,100,50,50))
        v.backgroundColor = UIColor.blueColor()
        v.layer.cornerRadius = v.bounds.size.width/2 - 5
        v.layer.borderWidth = 5
        v.layer.borderColor = UIColor.lightGrayColor().CGColor
        v.clipsToBounds = true
        self.view.addSubview(v)
    }
    
    func easingTest(){
        cl = CALayer()
        cl.frame = CGRectMake(0, 100, 50, 50)
        cl.cornerRadius = 10
        cl.borderColor = UIColor.redColor().CGColor
        cl.borderWidth = 2
        self.view.layer.addSublayer(cl)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var touch = (touches.first as! UITouch).locationInView(self.view)
       // moveLayer(touch)
       // moveView(touch)
       // changeColor()
       // performRotation()
    }
    
    func performRotation(){
        var animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.byValue = CGFloat(M_PI*2)
        animation.duration = 5
        animation.repeatCount = 4
        animation.removedOnCompletion = false
        (cl as! CAShapeLayer).addAnimation(animation, forKey: "circleRotate")
    }
    
    func moveView(touchPoint: CGPoint){
        UIView.animateWithDuration(5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.v.center = touchPoint
            self.v.transform = CGAffineTransformRotate(self.v.transform, CGFloat(M_PI / 2))
        }, completion: nil)
    }
    
    func moveLayer(touchPoint: CGPoint){
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        cl.position = touchPoint
        
        if flag{
            var transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
            cl.transform = CATransform3DMakeAffineTransform(transform)
            flag = false
        }else{
            var transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2))
            cl.transform = CATransform3DMakeAffineTransform(transform)
            flag = true
        }
        
        CATransaction.commit()
    }
    
    func cometDial(){
        // container view
        var v = UIView(frame: CGRectMake(0, 100, 300, 300))
        //v.backgroundColor = UIColor.blueColor()
        self.view.addSubview(v)
        
       // v.layer.contents = UIImage(named: "earth")?.CGImage
        
        // add circle layer
        var path = UIBezierPath(arcCenter: CGPointMake(v.bounds.width/2, v.bounds.height/2), radius: v.bounds.width/2 - 50, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        
        shapeLayer.fillColor = UIColor.blueColor().CGColor
        shapeLayer.strokeColor = UIColor.clearColor().CGColor

        
        v.layer.addSublayer(shapeLayer)
        
        
        
        // add outerlayer
//        var outerPath = UIBezierPath(arcCenter: CGPointMake(shapeLayer.bounds.width,shapeLayer.bounds.height), radius: 4, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
//        var outerLayer = CAShapeLayer()
//        outerLayer.path = outerPath.CGPath
//        outerLayer.position = CGPointMake(100, 100)
//        outerLayer.fillColor = UIColor.clearColor().CGColor
//        outerLayer.strokeColor = UIColor.lightGrayColor().CGColor
//        outerLayer.lineWidth = 10
//        outerLayer.lineJoin = kCALineJoinMiter
//        outerLayer.lineCap = kCALineCapRound
        var outerLayer = CALayer()
        var image = UIImage(named: "asteroid")!
        outerLayer.contents = image.CGImage
        outerLayer.frame = CGRectMake(0, 0, 25, 25)
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI_4))
        outerLayer.transform = CATransform3DMakeAffineTransform(transform)
        v.layer.addSublayer(outerLayer)
        
        // path for ball
        var ballPath = UIBezierPath(arcCenter: CGPointMake(v.bounds.width/2, v.bounds.height/2), radius: v.bounds.width/2 - 35, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
        
        // animation
        var pathAnimation = CAKeyframeAnimation()
        pathAnimation.keyPath = "position"
        // instead using duration of 4 sec from animation group
        pathAnimation.duration = 10.0
        pathAnimation.path = ballPath.CGPath
        
        pathAnimation.rotationMode = kCAAnimationRotateAutoReverse
        pathAnimation.repeatCount = Float.infinity
        outerLayer.addAnimation(pathAnimation, forKey: "outerLayerAnimation")
        
        // animation 
//        var animation = CABasicAnimation()
//        animation.keyPath = "transform.rotation"
//        animation.duration = 1.0
//        animation.repeatCount = Float.infinity
//        animation.byValue = M_PI * 2
//        
//        outerLayer.anchorPoint = CGPointMake(1, 0.5)
//        outerLayer.position =  CGPointMake(v.bounds.size.width/2 - 200, v.bounds.size.height/2)
//        outerLayer.addAnimation(animation, forKey: "outerLayerAnimation")
    }
    
    func gradientDial(){
        var v = UIView(frame: CGRectMake(0, 100, 300, 300))
        //v.backgroundColor = UIColor.redColor()
        
        // circle shape of radius half of rect width
        var shapeLayer = CAShapeLayer()
        var path = UIBezierPath()
        path.addArcWithCenter(CGPointMake(v.frame.width/2.0, v.frame.height/2.0), radius: v.frame.width/2.0 - 10, startAngle: CGFloat(0), endAngle: CGFloat(M_PI*2), clockwise: false)
    
        shapeLayer.path = path.CGPath
        shapeLayer.position = CGPointZero
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.lineWidth = 15
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineJoin = kCALineCapButt
        
        // stroke animation to draw line
        var animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 5
        animation.repeatCount = 1
        animation.removedOnCompletion = false
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // addAnimation to the layer
        shapeLayer.addAnimation(animation, forKey: "drawCircle")
        
        
        // add gradientLayer to base layer and mask it with shapelayer created earlier
        var gradientLayer = CAGradientLayer()
        gradientLayer.frame = v.bounds
        gradientLayer.colors = [UIColor.redColor().CGColor, UIColor.blueColor().CGColor, UIColor.greenColor().CGColor, UIColor.yellowColor().CGColor, UIColor.brownColor().CGColor]
        gradientLayer.locations = [0.0, 0.25, 0.5, 0.75, 1.0]
        
        gradientLayer.mask = shapeLayer
        v.layer.addSublayer(gradientLayer)
        self.view.addSubview(v)
        
        // add uilabel
        var label = UILabel(frame: CGRectMake(v.frame.width/2 - v.bounds.width/2, v.frame.height/2 - 40, v.bounds.width, 80))
        
        label.textColor = UIColor.blueColor()
        label.text = "Hola Como Esta!"
        //label.backgroundColor = UIColor.brownColor()
        label.textAlignment = NSTextAlignment.Center
        
        v.addSubview(label)
    }
    
//    func reflectionLayer(){
//        var refView = reflectionView(CGRectMake(100, 100, 200, 200))
//        //refView.backgroundColor = UIColor.lightGrayColor()
//        var img = UIImageView(frame: CGRectMake(0, 0, 50, 50))
//        img.image = (UIImage(named: "nerdy"))!
//        
//        refView.addSubview(img)
//        self.view.addSubview(refView)
//    }
    
    func textLayer(){
        var textView = UIView(frame: CGRectMake(100, 100, 200, 200))
       // textView.backgroundColor = UIColor.redColor()
        var textL = CATextLayer()
        textL.frame = textView.bounds
        
        
        textL.foregroundColor = UIColor.grayColor().CGColor
        textL.alignmentMode = kCAAlignmentJustified
        textL.wrapped = true
        
        var font = UIFont(name: "Bradley Hand", size: convertToCGFloat(15.0))
        
        textL.font = CGFontCreateWithFontName(font?.fontName as! CFString)
        textL.fontSize = font!.pointSize

        var text = "blah 🏃🏃🚶⛄️⚽️⚽️🏀 blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah blah"
        
        textL.contentsScale = UIScreen.mainScreen().scale
        
        var str = NSMutableAttributedString(string: text)
        
        var fontRef = CTFontCreateWithName(font!.fontName as CFString, font!.pointSize, nil)
        
        var attrs: [NSObject: AnyObject] = [kCTForegroundColorAttributeName: UIColor.grayColor().CGColor, kCTFontAttributeName: fontRef]
        
        str.setAttributes(attrs, range: NSMakeRange(0, count(text)))
        
        attrs = [kCTForegroundColorAttributeName: UIColor.blueColor().CGColor, kCTUnderlineStyleAttributeName: NSNumber(int: CTUnderlineStyle.Double.rawValue), kCTFontAttributeName: fontRef]
        
        str.setAttributes(attrs, range: NSMakeRange(5, 14))
        
        str.setAttributes(attrs, range: NSMakeRange(20, 4))
        
        textL.string = str
        
        textView.layer.addSublayer(textL)
        self.view.addSubview(textView)
    }
    
    func roundedButton(){
        var button = UIButton(frame: CGRectMake(100, 100, 150, 40))
        button.setTitle("My Button", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        //button.backgroundColor = UIColor.redColor()
        
        var rect = button.bounds
        var radii = CGSizeMake(20, 20)
        
        var corners = UIRectCorner.TopLeft | UIRectCorner.BottomRight
        
        var path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        
        var shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGrayColor().CGColor
        // UIColor * color = [UIColor colorWithRed:212/255.0f green:246/255.0f blue:122/255.0f alpha:1.0f];
        shapeLayer.fillColor = UIColor(red: convertToCGFloat(212.0/255.0), green: convertToCGFloat(246.0/255.0), blue: convertToCGFloat(122.0/255.0), alpha: convertToCGFloat(1.0)).CGColor
        shapeLayer.lineWidth = 5.0
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = path.CGPath
        
        //button.layer.mask = shapeLayer
        button.layer.addSublayer(shapeLayer)
        
        self.view.addSubview(button)
    }
    
    func canvasExample(){
        var path = UIBezierPath()
        path.moveToPoint(CGPointMake(75, 150))
        path.addArcWithCenter(CGPointMake(50, 150), radius: 25, startAngle: convertToCGFloat(0), endAngle: convertToCGFloat(2 * M_PI), clockwise: true)
        path.moveToPoint(CGPointMake(50, 175))
        path.addLineToPoint(CGPointMake(50, 225))
        path.moveToPoint(CGPointMake(50, 185))
        path.addLineToPoint(CGPointMake(125, 150))
        
        var shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.blueColor().CGColor
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.lineWidth = 5
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path  = path.CGPath
        
        self.view.layer.addSublayer(shapeLayer)
    }
    
    func addViewOne(){
        var viewOne = UIView(frame: CGRectMake(100, 100, 100, 100))
        let image = UIImage(named: "nerdy")
        viewOne.layer.contents = image?.CGImage
        self.view.addSubview(viewOne)
        
        // apply 3d flip
        var transform = CATransform3DIdentity
        
        // apply perspective
        transform.m34 = -1.0/1000
        
        // apply 3d rotation 360 degrees
        transform = CATransform3DRotate(transform, convertToCGFloat(M_PI), convertToCGFloat(0), convertToCGFloat(1), convertToCGFloat(0))
        
        UIView.animateWithDuration(2, animations: { () -> Void in
            viewOne.layer.transform = transform
        })
    }
    
    func convertToCGFloat(val: Double) -> CGFloat{
        return CGFloat(val)
    }
}
