//
//  SphereGradient2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/30/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class SphereGradient2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let locations: [CGFloat] = [0.0, 1.0]
        let colors = [UIColor.whiteColor().CGColor, UIColor.blueColor().CGColor]
        let colorSpage = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorSpage, colors, locations)
        
        var startPoint = CGPoint()
        var endPoint = CGPoint()
        
        startPoint.x = 180
        startPoint.y = 180
        
        endPoint.x = 200
        endPoint.y = 200
        
        let startRadius: CGFloat = 0
        let endRadius: CGFloat = 75
        
        CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0)
    }
}
