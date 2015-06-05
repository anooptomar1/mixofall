//
//  GameScene.swift
//  spaceInvaders
//
//  Created by Anoop tomar on 6/2/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import SpriteKit

var invaderNum = 1

class GameScene: SKScene {
    let rowOfInvaders = 4
    var invaderSpeed = 2
    let leftBound = CGFloat(30)
    var rightBound = CGFloat(0)
    var invadersWhoCanFire: [Invader] = []
    var invaderWhoCanFire:[Invader] = [Invader]()
    let player: Player = Player()
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        setupInvaders()
        setupPlayers()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        
    }
    
    func setupPlayers(){
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height/2 + 10)
        addChild(player)
    }
    
    func setupInvaders(){
        var invaderRow = 0
        var invaderColumn = 0
        let numberIfInvaders = invaderNum * 2 + 1
        for var i = 1; i <= rowOfInvaders; i++ {
            invaderRow = i
            for var j = 1; j <= numberIfInvaders; j++ {
                invaderColumn = j
                let tempInvader: Invader = Invader()
                let invaderHalfOfWidth: CGFloat = tempInvader.size.width / 2
                let xPositionStart: CGFloat = size.width / 2 - invaderHalfOfWidth - (CGFloat(invaderNum) * tempInvader.size.width) + CGFloat(10)
                tempInvader.position = CGPoint(x: xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y: CGFloat(self.size.height - CGFloat(i) * 46))
                tempInvader.invaderRow = invaderRow
                tempInvader.invaderColumn = invaderColumn
                addChild(tempInvader)
                if i == rowOfInvaders{
                    invadersWhoCanFire.append(tempInvader)
                }
            }
        }
    }
}
