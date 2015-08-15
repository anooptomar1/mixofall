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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.reflectionLayer()
        //self.textLayer()
        //self.roundedButton()
        //self.addViewOne()
        //self.canvasExample()
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
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
