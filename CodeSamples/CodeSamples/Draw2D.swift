//
//  Draw2D.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/21/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class Draw2D: UIView {
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let startXPosition: CGFloat = 30
        let endXPosition: CGFloat = 300
        let startYPosition: CGFloat = 30
        let endYPosition: CGFloat = 500
        
        CGContextSetLineWidth(context, 2)
    //    let colorSpace = CGColorSpaceCreateDeviceRGB()
  //      let components: [CGFloat] = [0.0, 0.0, 0.5, 0.5]
//        let color = CGColorCreate(colorSpace, components)
        
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextMoveToPoint(context, startXPosition, startYPosition)
        CGContextAddLineToPoint(context, endXPosition, startYPosition)
        CGContextMoveToPoint(context, startXPosition, endYPosition)
        CGContextAddLineToPoint(context, endXPosition, startYPosition)
        CGContextMoveToPoint(context, startXPosition, endYPosition)
        CGContextAddLineToPoint(context, endXPosition, endYPosition)
        CGContextMoveToPoint(context, endXPosition, endYPosition)
        CGContextAddLineToPoint(context, startXPosition, startYPosition)
        CGContextStrokePath(context)
    }

}
