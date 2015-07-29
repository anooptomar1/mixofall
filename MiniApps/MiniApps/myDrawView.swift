//
//  myDrawView.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/20/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class MyDrawView: UIView {
    
    var touchPoints = [CGPoint]()
    var con: CGContext?
    
    override func drawRect(rect: CGRect) {
        if touchPoints.count > 1 {
            //CGContextRestoreGState(con)
            con = UIGraphicsGetCurrentContext()
            var lastPoint = touchPoints.removeLast()
            CGContextMoveToPoint(con, lastPoint.x, lastPoint.y)
            CGContextAddLineToPoint(con, touchPoints.last!.x, touchPoints.last!.y)
            CGContextSetRGBStrokeColor(con, 0.0, 0.0, 1.0, 1.0)
            CGContextSetLineWidth(con, 10)
            CGContextStrokePath(con)
           // CGContextSaveGState(con)
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch in touches as! Set<UITouch>{
            touchPoints.append(touch.locationInView(self))
        }
        self.setNeedsDisplay()
    }
}
