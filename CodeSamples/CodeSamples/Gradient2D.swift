//
//  Gradient2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/30/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class Gradient2D: UIView {


    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let locations: [CGFloat] = [0.0, 0.25, 0.5, 0.75, 1.0]
        let colors = [UIColor.yellowColor().CGColor, UIColor.blueColor().CGColor, UIColor.greenColor().CGColor, UIColor.redColor().CGColor, UIColor.grayColor().CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        startPoint.x = UIScreen.mainScreen().bounds.size.width
        startPoint.y = 0.0
        
        endPoint.x = UIScreen.mainScreen().bounds.size.width
        endPoint.y = UIScreen.mainScreen().bounds.size.height
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        
    }
    
}
