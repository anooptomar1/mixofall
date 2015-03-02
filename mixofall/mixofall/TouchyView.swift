//
//  TouchyView.swift
//  mixofall
//
//  Created by Anoop tomar on 3/1/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class TouchyView: UIView{
    
    var touchPoints = [CGPoint]()
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        updateTouches(event.allTouches())
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        //updateTouches(event.allTouches())
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
       // updateTouches(event.allTouches())
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
       // updateTouches(event.allTouches())
    }
    
    func updateTouches(touches: NSSet?){
        //touchPoints = []
        touches?.enumerateObjectsUsingBlock({ (element, stop) -> Void in
            if let touch = element as? UITouch{
                switch touch.phase{
                case .Began, .Moved,.Stationary:
                    self.touchPoints.append(touch.locationInView(self))
                    //println("\(touch.locationInView(self).x), \(touch.locationInView(self).y)")
                default: break
                }
                
            }
        })
        
     setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        UIColor.lightGrayColor().set()
        CGContextFillRect(context, rect)

        var connectionPath: UIBezierPath?
        
        if touchPoints.count > 1{
            for location in touchPoints{
                if let path = connectionPath{
                    path.addLineToPoint(location)
                }else{
                    connectionPath = UIBezierPath()
                    connectionPath!.moveToPoint(location)
                }
            }
            if touchPoints.count > 2{
               // connectionPath!.closePath()
            }
        }
        
        if let path = connectionPath{
            UIColor.whiteColor().set()
            path.lineWidth = 2
            path.lineJoinStyle = kCGLineJoinRound
            path.lineCapStyle = kCGLineCapRound
            path.stroke()
        }
        
        var touchNumber = 0
        let fontAttribute = [
            NSFontAttributeName: UIFont.boldSystemFontOfSize(12),
            NSForegroundColorAttributeName: UIColor.blackColor()
        ]
        
        for location in touchPoints{
            let text: NSString = "\(++touchNumber)"
            let size = text.sizeWithAttributes(fontAttribute)
            let textCorner = CGPoint(x: location.x - size.width/2, y: location.y - size.height/2)
            //text.drawAtPoint(textCorner, withAttributes: fontAttribute)
            var subrect = CGRectMake(location.x, location.y, 20, 20)
            UIColor.brownColor().set()
            CGContextFillRect(UIGraphicsGetCurrentContext(), subrect)
            text.drawInRect(rect, withAttributes: fontAttribute)
        }
    }
    
}
