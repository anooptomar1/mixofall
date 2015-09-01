//
//  GraphView.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/29/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit



@IBDesignable
class GraphView: UIView {
    var graphPoints: [Int] = [4, 2, 6, 4, 5, 8, 3]
    
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    
    override func drawRect(rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, colorLocations)
        
        var startPoint = CGPoint.zeroPoint
        var endPoint = CGPoint(x: 0, y: self.bounds.height)
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        
        layer.cornerRadius = 8
        
        clipsToBounds = true
        
        //calculate the x point
        let margin: CGFloat = 20.0
        var columnXPoint = { (column: Int) -> CGFloat in
            let spacer = (width - margin*2 - 4) / CGFloat((self.graphPoints.count - 1))
            var x: CGFloat = CGFloat(column) * spacer
            x += margin + 2
            return x
        }
    }
    
}
