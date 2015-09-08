//
//  tictactoeViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class tictactoeViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var newPlayView: UIView!
    var gameOn = 1
    
    @IBOutlet var buttons: [UIButton]!
    var winner = false
    
    // 0: untouched, 1: circle, 2: cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winningCombo = [[0, 1, 2],
                        [3, 4, 5],
                        [6, 7, 8],
                        [0, 3, 6],
                        [1, 4, 7],
                        [2, 5, 8],
                        [0, 4, 8],
                        [2, 4, 6]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNewPlayScreen(false)
    }

    @IBAction func didPressCloseButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressPlayAgain(sender: UIButton) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        winner = false
        gameOn = 1
        
        for v in buttons{
            v.setImage(UIImage(), forState: UIControlState.Normal)
        }
        
        showNewPlayScreen(false)
        
    }
    @IBAction func didPressGridButton(sender: UIButton){
        
        if (gameState[sender.tag] == 0 && !winner){
            
            var image: UIImage?
            
            if gameOn % 2 == 0{
                image = UIImage(named: "circle146")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                gameState[sender.tag] = 1
                sender.setImage(image!, forState: UIControlState.Normal)
                sender.tintColor = UIColor.orangeColor()
            }else{
                image = UIImage(named: "cross-mark1")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                gameState[sender.tag] = 2
                sender.setImage(image!, forState: UIControlState.Normal)
                sender.tintColor = UIColor.blueColor()
            }
            
            gameOn++
            checkWinStatus()
            checkGameState()
        }
        
    }
    
    func checkGameState(){
        var countArr = gameState.filter { (val) -> Bool in
            return val == 0
        }
        if countArr.count <= 0{
            messageLabel.text = "Draw!"
            showNewPlayScreen(true)
        }
    }
    
    func checkWinStatus(){
        for combo in winningCombo{
            if((gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]]) && gameState[combo[1]] != 0){
                messageLabel.text = gameState[combo[0]] == 1 ? "Circle Won!" : "Cross Won!"
                showNewPlayScreen(true)
                winner = true
            }
        }
    }
    
    func showNewPlayScreen(show: Bool){
        if show{
            self.newPlayView.alpha = 0.95
        }else{
            self.newPlayView.alpha = 0
        }
    }
}
