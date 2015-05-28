//
//  BezierCurve2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class BezierCurve2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.orangeColor().CGColor)
        CGContextMoveToPoint(context, 30, 30)
        CGContextAddCurveToPoint(context, 0, 50, 300, 250, 300, 400)
        CGContextStrokePath(context)
    }

}
