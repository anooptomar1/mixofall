//
//  shapeLayerView.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/20/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class shapeLayerView: UIView {
  
    override class func layerClass() -> AnyClass{
        return CAShapeLayer.self
    }

}
