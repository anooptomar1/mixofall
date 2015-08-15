//
//  reflectionView.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/12/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class reflectionView: CAReplicatorLayer {

    func setUp(){
        self.instanceCount = 2
        
        var transform = CATransform3DIdentity
        
        var offset: CGFloat = self.bounds.size.height + 2
        transform = CATransform3DTranslate(transform, 0, offset, 0)
        transform = CATransform3DScale(transform, 1, -1, 0)
        
        self.instanceAlphaOffset = -0.6
        
    }
    
    override init!() {
        super.init()
        setUp()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUp()
    }
    
    override func awakeFromNib() {
        self.setUp()
    }
    
}
