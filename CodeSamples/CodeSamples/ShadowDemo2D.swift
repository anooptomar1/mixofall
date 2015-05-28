//
//  ShadowDemo2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/27/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ShadowDemo2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let myShadowOffset = CGSizeMake(-10, 15)
        CGContextSaveGState(context)
        CGContextSetShadow(context, myShadowOffset, 5)
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        var initX:CGFloat = 60
        for index in 0...3{
            var rectangle = CGRectMake(initX, 170, 30, 50)
            CGContextAddEllipseInRect(context, rectangle)
            initX += 60
        }
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }

}
