//
//  RandomLineView.swift
//  mixofall
//
//  Created by Anoop tomar on 3/1/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class RandomLineView: UIView{
    var points = [CGPoint]()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setNeedsDisplay()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        points = []
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        UIColor.brownColor().set()
        CGContextFillRect(context, rect)
        
        for i in 1...10{
            var randomX = CGFloat(arc4random_uniform(UInt32(self.bounds.maxX)))
            var randomY = CGFloat(arc4random_uniform(UInt32(self.bounds.maxY)))
            points.append(CGPoint(x: randomX, y: randomY))

        }
        
        var connectionPath: UIBezierPath!
        
        if points.count > 1{
            for point in points{
                if let path = connectionPath{
                    path.addLineToPoint(point)
                }else{
                    connectionPath = UIBezierPath()
                    connectionPath.moveToPoint(point)
                }
            }
        }
        
        if(points.count > 2){
            connectionPath.closePath()
        }
        
        if let path = connectionPath{
            path.lineWidth = 4
            UIColor.blackColor().set()
            path.lineCapStyle = kCGLineCapRound
            path.lineJoinStyle = kCGLineJoinBevel
            path.stroke()
        }
        
    }
}
