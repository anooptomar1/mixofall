//
//  Arc2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class Arc2D: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextMoveToPoint(context, 30, 30)
        CGContextAddArcToPoint(context, 30, 100, 300, 200, 100)
        CGContextStrokePath(context)
    }

}
