//
//  CounterVIew.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/23/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

let numberOfGlasses = 8
let pi = CGFloat(M_PI)

@IBDesignable
class CounterVIew: UIView {

    @IBInspectable var counter:Int = 8{
        didSet{
            if counter <= numberOfGlasses{
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor.orangeColor()
    
    override func drawRect(rect: CGRect) {
        let center = CGPoint(x: bounds.width/2, y: bounds.height/2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        let arcWidth: CGFloat = 76
        
        let startAngle: CGFloat = CGFloat(3*pi/4)
        let endAngle: CGFloat = CGFloat(pi/4)
        
        var path = UIBezierPath(arcCenter: center, radius: radius/2 - arcWidth/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        let angleDifference: CGFloat =  2*pi - startAngle + endAngle
        let arcLengthPerGlass = angleDifference/CGFloat(numberOfGlasses)
        let outerEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        var outlinePath = UIBezierPath(arcCenter: center, radius: bounds.width/2 - 2.5, startAngle: startAngle, endAngle: outerEndAngle, clockwise: true)
        outlinePath.addArcWithCenter(center, radius: bounds.width/2 - arcWidth + 2.5, startAngle: outerEndAngle, endAngle: startAngle, clockwise: false)
        outlinePath.closePath()
        outlinePath.lineWidth = 5.0
        outlineColor.setStroke()
        outlinePath.stroke()
    }
    
}
