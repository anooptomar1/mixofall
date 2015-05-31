//
//  RadialGradient2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/30/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class RadialGradient2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let locations: [CGFloat] = [0.0, 0.5, 1.0]
        let colors = [UIColor.redColor().CGColor, UIColor.greenColor().CGColor, UIColor.blueColor().CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        startPoint.x = 100
        startPoint.y = 100
        endPoint.x = UIScreen.mainScreen().bounds.width - 100
        endPoint.y = UIScreen.mainScreen().bounds.width - 100
        
        var startRadius: CGFloat = 10
        var endRadius: CGFloat = 50
        
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0)
    }

}
