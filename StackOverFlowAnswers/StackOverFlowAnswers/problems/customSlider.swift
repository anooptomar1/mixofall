//
//  customSlider.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/26/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class customSlider: UISlider {
    override func trackRectForBounds(bounds: CGRect) -> CGRect {
        var result = super.trackRectForBounds(bounds)
        result.size.height = 2.00
        return result
    }
    
    override func drawRect(rect: CGRect) {
        let c = UIGraphicsGetCurrentContext()
        UIColor.redColor().set()
        let ins: CGFloat = 2.0
        let r = CGRectInset(self.bounds, ins, ins)
        let radius = r.size.height / 2.0
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGRectGetMaxX(r) - radius, ins)
        CGPathAddArc(path, nil, radius + ins, radius + ins, radius, CGFloat(-M_PI/2.0), CGFloat(M_PI/2), true)
        CGPathAddArc(path, nil, CGRectGetMaxX(r) - radius, radius + ins, radius, CGFloat(M_PI/2), CGFloat(-M_PI/2), true)
        CGPathCloseSubpath(path)
        CGContextAddPath(c, path)
        CGContextSetLineWidth(c, CGFloat(2))
        CGContextStrokePath(c)
        CGContextAddPath(c, path)
        CGContextClip(c)
        CGContextFillRect(c, CGRectMake(r.origin.x, r.origin.y, CGFloat(r.size.width) * CGFloat(self.value), r.size.height))
    }
}
