//
//  DashedLine2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/27/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class DashedLine2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 20.0)
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        let dashArray: [CGFloat] = [2, 6, 4, 2]
        CGContextSetLineDash(context, 3, dashArray, 4)
        CGContextMoveToPoint(context, 10, 200)
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200)
        CGContextStrokePath(context)
    }
    
}
