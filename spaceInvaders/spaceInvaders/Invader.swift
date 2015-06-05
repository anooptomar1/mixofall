//
//  Invader.swift
//  spaceInvaders
//
//  Created by Anoop tomar on 6/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import SpriteKit

class Invader: SKSpriteNode {
   
    var invaderRow = 0
    var invaderColumn = 0
    
    init(){
        let texture = SKTexture(imageNamed: "invader1")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.name = "invader"
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func fireBullet(scene: SKScene){
        
    }
    
}
