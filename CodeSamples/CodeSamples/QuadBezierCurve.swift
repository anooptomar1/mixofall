//
//  QuadBezierCurve.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class QuadBezierCurve: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.orangeColor().CGColor)
        CGContextMoveToPoint(context, 10, 200)
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200)
        CGContextStrokePath(context)
    }
}
