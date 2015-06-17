//
//  ScrollView.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/16/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import QuartzCore

class ScrollView: UIView {

    override class func layerClass() -> AnyClass{
        return CAScrollLayer.self
    }
}
