//
//  tictactoeViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import AVFoundation

class tictactoeViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var newPlayView: UIView!
    var gameOn = 1
    
    var audioPlayer: AVAudioPlayer!
    var drawPlayer: AVAudioPlayer!
    var winPlayer: AVAudioPlayer!
    
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
        var url = NSBundle.mainBundle().URLForResource("flute", withExtension: "aiff")
        audioPlayer = AVAudioPlayer(contentsOfURL: url!, error: nil)
        audioPlayer.prepareToPlay()
        
        var drawurl = NSBundle.mainBundle().URLForResource("boing", withExtension: "aiff")
        drawPlayer = AVAudioPlayer(contentsOfURL: drawurl!, error: nil)
        drawPlayer.prepareToPlay()
        
        var winUrl = NSBundle.mainBundle().URLForResource("swoosh", withExtension: "aiff")
        winPlayer = AVAudioPlayer(contentsOfURL: winUrl!, error: nil)
        winPlayer.prepareToPlay()
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
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (count(cString) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    @IBAction func didPressGridButton(sender: UIButton){
        
        if (gameState[sender.tag] == 0 && !winner){
            
            playTapSound()
            
            var image: UIImage?
            
            if gameOn % 2 == 0{
                image = UIImage(named: "circle146")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                gameState[sender.tag] = 1
                sender.setImage(image!, forState: UIControlState.Normal)
                sender.tintColor = hexStringToUIColor("#FEC33A")
            }else{
                image = UIImage(named: "cross-mark1")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                gameState[sender.tag] = 2
                sender.setImage(image!, forState: UIControlState.Normal)
                sender.tintColor = hexStringToUIColor("#0A5499")
            }
            
            gameOn++
            checkWinStatus()
            if !winner{
                checkGameState()
            }
        }
        
    }
    
    func playTapSound(){
        audioPlayer.play()
    }
    
    func checkGameState(){
        var countArr = gameState.filter { (val) -> Bool in
            return val == 0
        }
        if countArr.count <= 0{
            messageLabel.text = "Draw!"
            drawPlayer.play()
            showNewPlayScreen(true)
        }
    }
    
    func checkWinStatus(){
        for combo in winningCombo{
            if((gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]]) && gameState[combo[1]] != 0){
                messageLabel.text = gameState[combo[0]] == 1 ? "Circle Won!" : "Cross Won!"
                winPlayer.play()
                showNewPlayScreen(true)
                winner = true
            }
        }
    }
    
    func showNewPlayScreen(show: Bool){
        if show{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.newPlayView.center = CGPointMake(self.newPlayView.center.x + 500, self.newPlayView.center.y)
                self.newPlayView.alpha = 0.95
            })

            //
        }else{
            self.newPlayView.alpha = 0
        }
    }
}
