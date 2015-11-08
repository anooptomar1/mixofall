//
//  streamingPlayerViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/25/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

// implement buffer status uislider with answer below
//http://stackoverflow.com/questions/4495433/uislider-with-progressview-combined



import UIKit
import AVFoundation

class streamingPlayerViewController: UIViewController{

    
    // all iboutlets
    @IBOutlet weak var bufferSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var bufferedTimeLabel: UILabel!
    @IBOutlet weak var controlButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    // all local vars
    var app = UIApplication.sharedApplication().delegate as! AppDelegate
    var streamingUrl: NSURL?
    var timer: NSTimer?
    var seekTime: CMTime?
    var defaults = NSUserDefaults.standardUserDefaults()
    
    // flags
    var isPlaying: Bool = false
    
    private let observingKeypath = "currentItem.status"
    private let playerStatusObservingContext = UnsafeMutablePointer<Void>()
    private var statusIsBeingObserved = false
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // long audio
//        streamingUrl = NSURL(string: "http://k007.kiwi6.com/hotlink/3mwnaqoxf1?source=site&secret=14be03784a2f9eac02a58e0d16016fd1")
        // podcast audio link
        if audioPlayer == nil{
            initAudioPlayerIfNotComingfromBackground()
        }
        // hide thumb of the slider to show only progress bar
        slider.setThumbImage(UIImage(), forState: UIControlState.Normal)
        controlButton.alpha = 0.0
        bufferSlider.setThumbImage(UIImage(), forState: UIControlState.Normal)
        
        if let aplayer = audioPlayer{
            if aplayer.status.rawValue == 1{
                updateUI()
                isPlaying = true
                controlButton.setTitle("Stop", forState: UIControlState.Normal)
                controlButton.alpha = 1.0
                
            }
        }
    }
    
    func initAudioPlayerIfNotComingfromBackground(){
        streamingUrl = NSURL(string: "https://f07935ebb865536ef739aab1c0c15976981be54b.googledrive.com/host/0B10Ei6Zz1BH5c1NhNF85ZFMwUzA/mix_523m59s%20(audio-joiner.com).mp3")
        audioPlayer = app.initAndPlayAudio(streamingUrl!)
        audioPlayer?.addObserver(self, forKeyPath: observingKeypath, options: NSKeyValueObservingOptions.New, context: playerStatusObservingContext)
        findLastSavedTime()
    }

    // retriving values from NSUserDefaults and fwd seek to meet the saved pointer
    func findLastSavedTime(){
        if let data = defaults.objectForKey("seekTime"){
            if let decrypt = NSKeyedUnarchiver.unarchiveObjectWithData(data as! NSData) as? mySeekTime{
                seekTime = CMTime(value: decrypt.value, timescale: decrypt.timescale, flags: CMTimeFlags(rawValue: decrypt.flags), epoch: decrypt.epoch)
            }
        }
    }
    
    // close current sub item
    @IBAction func didClickDismiss(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // play button clicked
    @IBAction func didClickPlay(sender: UIButton) {
        setPlayerState()
    }
    
    // stop or play based on current state of the button
    func setPlayerState(){
        if isPlaying{
            stopPlaying()
        }else{
            startPlaying()
        }
    }
    
    func stopPlaying(){
        controlButton.setTitle("Play", forState: UIControlState.Normal)
        audioPlayer!.pause()
        isPlaying = false
        audioPlayer?.currentTime()
        if let isTimer = timer{
            seekTime = audioPlayer!.currentTime()
            isTimer.invalidate()
            saveTimeInUserDefaults()
        }
        do{
            try AVAudioSession.sharedInstance().setActive(false)
        }catch{
            
        }
    }
    
    // this code is changing struct to class because NSUserDefaults can only save NSData, NSString, NSNumber, NSDate, NSArray, and NSDictionary. Struct do not conform to NSObject so the solution in place is to store values of struct into a class and encode that using encoder and decoding back to the class then struct while retriving from NSUserDefaults
    func saveTimeInUserDefaults(){
        let mySeekT = mySeekTime()
        mySeekT.value = seekTime!.value
        mySeekT.timescale = seekTime!.timescale
        mySeekT.flags = seekTime!.flags.rawValue
        mySeekT.epoch = seekTime!.epoch
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(mySeekT)
        defaults.setObject(encodedData, forKey: "seekTime")
        defaults.synchronize()
    }
    
    func startPlaying(){
        controlButton.setTitle("Stop", forState: UIControlState.Normal)
        if let st = seekTime{
            audioPlayer!.seekToTime(st)
        }
        audioPlayer!.play()
        audioPlayer!.rate = 1.0
        isPlaying = true
        updateUI()
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            
        }
        UIApplication.sharedApplication().beginReceivingRemoteControlEvents()
    }
    
    func updateUI(){
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        slider.minimumValue = 0
        slider.maximumValue = Float(audioPlayer!.currentItem!.duration.seconds)
        bufferSlider.minimumValue = 0
        bufferSlider.maximumValue = Float(audioPlayer!.currentItem!.duration.seconds)
        durationTimeLabel.text = convertSecondsToTimeString(audioPlayer!.currentItem!.duration.seconds)
    }
    
    // helper to convert seconds to 00:00:00 format string
    func convertSecondsToTimeString(seconds: Double) -> String{
        let hourRawValue = seconds / 3600
        let hour = Int(hourRawValue)
        let minuteRawValue = seconds - Double(hour * 3600)
        let minute = Int(minuteRawValue / 60)
        let secondsRawValue = minuteRawValue - Double(minute * 60)
        return String(format: "%02d:%02d:%02d", arguments: [hour, minute, Int(secondsRawValue)]) //("\(hour):\(minute):\(Int(secondsRawValue))")
    }
    
    // remove KVO observer before view disappear
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // making sure to remove observer before exiting from the VC
        if statusIsBeingObserved{
            audioPlayer?.removeObserver(self, forKeyPath: observingKeypath)
        }
        
        // save user position before exit
        if seekTime != nil{
            saveTimeInUserDefaults()
        }
        if timer != nil{
            timer!.invalidate()
        }
    }
    
//    http://stackoverflow.com/questions/31010255/issue-with-func-observevalueforkeypathkeypath-nsstring-object-anyobject
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == playerStatusObservingContext
        {
            statusIsBeingObserved = true
            
            if let change = change as? [String: Int]
            {
                let newChange = change[NSKeyValueChangeNewKey]!
                switch newChange
                {
                case AVPlayerItemStatus.ReadyToPlay.rawValue:
                    controlButton.alpha = 1.0
                    
                default:
                    controlButton.alpha = 1.0
                    controlButton.enabled = false
                    controlButton.setTitle("Try again", forState: UIControlState.Normal)
                }
                
            }
            
            return
        }
        super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
    }
    // http://stackoverflow.com/questions/29432410/get-current-time-of-video-playing-in-avplayer-ios
    //http://stackoverflow.com/questions/2654849/uislider-to-control-avaudioplayer
    func updateTime(){
        let l1 = Float(audioPlayer!.currentTime().value)
        let l2 = Float(audioPlayer!.currentTime().timescale)
        slider.value = l1/l2
        // show current time in label
        currentTimeLabel.text = convertSecondsToTimeString(Double(l1/l2))
        availableDuration()
        if audioPlayer!.rate == 0.0{
            stopPlaying()
        }
    }
    
    // http://stackoverflow.com/questions/7691854/avplayer-streaming-progress/7730708#7730708
    // getting info on how much data has been buffered
    func availableDuration(){
        // taking first value because there is only one item in array
        if let loadedTimeRange = (audioPlayer?.currentItem?.loadedTimeRanges.first) as NSValue?{
            let start = loadedTimeRange.CMTimeRangeValue.start
            let duration = loadedTimeRange.CMTimeRangeValue.duration
            // show buffered time in stream
            bufferedTimeLabel.text = convertSecondsToTimeString(start.seconds + duration.seconds)
            bufferSlider.value = Float(start.seconds + duration.seconds)
        }
    }
    
    // rewind 1min from current
    @IBAction func rewind5s(sender: UIButton) {
        if isPlaying{
            audioPlayer!.pause()
            let currentTime = CMTimeGetSeconds(audioPlayer!.currentItem!.currentTime())
            audioPlayer!.seekToTime(CMTimeMakeWithSeconds(currentTime - 60, Int32(NSEC_PER_SEC)))
            audioPlayer!.play()
        }
    }
    
    // restart from begining
    @IBAction func startOver(sender: UIButton) {
        if isPlaying{
            audioPlayer!.pause()
            audioPlayer!.seekToTime(CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
            audioPlayer!.play()
        }
    }
    
    // forward 1min from current
    @IBAction func fwd5s(sender: UIButton) {
        if isPlaying{
            audioPlayer!.pause()
            let currentTime = CMTimeGetSeconds(audioPlayer!.currentItem!.currentTime())
            audioPlayer!.seekToTime(CMTimeMakeWithSeconds(currentTime + 60, Int32(NSEC_PER_SEC)))
            audioPlayer!.play()
        }
    }
    
}
