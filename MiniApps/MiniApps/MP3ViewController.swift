//
//  MP3ViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 9/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import AVFoundation

class MP3ViewController: UIViewController {

    var player: AVAudioPlayer!
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var seek: UISlider!
    @IBOutlet weak var duration: UILabel!
    var timer = NSTimer()
    
    var didPause = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        player = AVAudioPlayer()
       
    }

    @IBAction func didPressPauseButton(sender: UIBarButtonItem) {
        player.pause()
        timer.invalidate()
        didPause = true
    }
    
    @IBAction func didPressStopButton(sender: UIBarButtonItem) {
        player.stop()
        seek.value = 0
        currentTime.text = String(format: "%02d:%02d", 0, 0)
        timer.invalidate()
        didPause = false
    }
    
    
    func tick(){
        var time = convertToMinSec(player.currentTime)
        currentTime.text = String(format: "%02d:%02d", time.min, time.sec)
        seek.value = Float(player.currentTime)
    }
    
    @IBAction func didPressCloseButton(sender: AnyObject){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func didPressPlay(sender: UIBarButtonItem) {
        if !didPause{
            var url = NSBundle.mainBundle().URLForResource("tailtoddle", withExtension: "mp3")
            player = AVAudioPlayer(contentsOfURL: url, error: nil)
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "tick", userInfo: nil, repeats: true)
        var time = convertToMinSec(player.duration)
        duration.text = String(format: "%02d:%02d", time.min, time.sec)
       
        seek.maximumValue = Float(player.duration)
        player.play()
    }
    
    override func viewDidDisappear(animated: Bool) {
        player.stop()
        timer.invalidate()
    }
    
    func convertToMinSec(time: NSTimeInterval) -> (min: Int, sec: Int){
        var min = Int(time / 60)
        var sec = Int(time % 60)
        return (min, sec)
    }
}
