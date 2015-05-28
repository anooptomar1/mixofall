//
//  MyDrawView.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/21/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class MyDrawView: UIView {

    @IBInspectable var startColor: UIColor = UIColor.orangeColor()
    @IBInspectable var endColor: UIColor = UIColor.orangeColor()
    @IBInspectable var endRadius: CGFloat = 10
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        var locations: [CGFloat] = [0.0, 1.0]
        
        var gradient = CGGradientCreateWithColors(colorSpace, [startColor.CGColor, endColor.CGColor], locations)
        
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        var startRadius: CGFloat = 50
        
        startPoint.x = 150
        startPoint.y = 180
        endPoint.x = 150
        endPoint.y = 180
        
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0)
        
    }

}
