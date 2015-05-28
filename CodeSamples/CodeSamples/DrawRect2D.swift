//
//  DrawRect2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class DrawRect2D: UIView {

    
    var width: CGFloat = 100
    var height: CGFloat = 100
    var startPosition: CGFloat = 0
    var endPosition: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        let rectangle = CGRectMake(startPosition, endPosition, width, height)
        //CGContextAddRect(context, rectangle)
        CGContextAddEllipseInRect(context, rectangle)
        CGContextSetFillColorWithColor(context, UIColor.blueColor().CGColor)
        // below code is for drawing only stroke
        CGContextStrokePath(context)
        // below code is for drawing fill shape
        CGContextFillEllipseInRect(context, rectangle)
    }

}
