//
//  progressView.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class progressView: UIView {

    private let progressLayer = CAShapeLayer()
    private var progressLabel: UILabel
    
    required init?(coder aDecoder: NSCoder) {
        self.progressLabel = UILabel()
        super.init(coder: aDecoder)
        createProgressLabel()
        createProgressLayer()
    }
    
    override init(frame: CGRect) {
        self.progressLabel = UILabel()
        super.init(frame: frame)
        createProgressLabel()
        createProgressLayer()
    }
    
    func animateProgressView(){
        progressLayer.strokeEnd = 0.0
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = CGFloat(0.0)
        animation.toValue = CGFloat(1.0)
        animation.duration = 10.0
        animation.fillMode = kCAFillModeForwards
        animation.additive = true
        animation.delegate = self
        animation.removedOnCompletion = false
        progressLayer.addAnimation(animation, forKey: "anomating stroke")
    }
    
    func createProgressLabel(){
        progressLabel.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 60)
        progressLabel.textColor = UIColor.blackColor()
        progressLabel.textAlignment = NSTextAlignment.Center
        progressLabel.text = "810"
        progressLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 60)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressLabel)
        
        addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: progressLabel, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: progressLabel, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0))
    }
    
    func createProgressLayer(){
        let startAngle = CGFloat(140 * M_PI/180)
        let endAngle = CGFloat(40 * M_PI/180)
        let center = CGPointMake(CGRectGetWidth(frame)/2, CGRectGetHeight(frame)/2)
        let radius = CGRectGetWidth(frame)/2
        let path = UIBezierPath()
        
        path.addArcWithCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressLayer.path = path.CGPath
        progressLayer.backgroundColor = UIColor.clearColor().CGColor
        progressLayer.strokeColor = UIColor.blueColor().CGColor
        progressLayer.fillColor = nil
        progressLayer.lineWidth = 10.0
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 1.0
        
        layer.addSublayer(progressLayer)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if flag == true{
            progressLabel.text = progressLabel.text!
            progressLabel.textColor = UIColor.greenColor()
        }
    }

}
