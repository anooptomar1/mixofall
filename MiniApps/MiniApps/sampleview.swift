//
//  sampleview.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class sampleview: UIView {

    override func drawRect(rect: CGRect) {
        let p = UIBezierPath(ovalInRect: CGRectMake(0, 0, 48, 48))
        UIColor.blueColor().setFill()
        p.fill()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("ouch")
    }
}
