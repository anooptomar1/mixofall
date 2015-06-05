//
//  StartGameScene.swift
//  spaceInvaders
//
//  Created by Anoop tomar on 6/3/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        println("start screen is loaded")
        
        let startGameButton = SKSpriteNode(imageNamed: "newgamebtn")
        startGameButton.position = CGPointMake(size.width / 2 , (size.height / 2))
        startGameButton.name = "startgame"
        addChild(startGameButton)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(touchLocation)
        if touchedNode.name == "startgame"{
            let gameOverScreen = GameScene(size: size)
            gameOverScreen.scaleMode = scaleMode
            let transitionType = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 1.0)
            
            view?.presentScene(gameOverScreen, transition: transitionType)
        }
    }
}
