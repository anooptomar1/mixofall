//
//  CTViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/22/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class CTViewController: UIViewController, NSURLSessionDownloadDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var myprogressView: UIProgressView!
    var serialQueue: NSOperationQueue?
    var mainQueue: NSOperationQueue?
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var textb: UITextField!
    var add = {(a: Int, b: Int) -> Int in return a + b}

    override func viewDidLoad() {
        super.viewDidLoad()
        XMLParsingExample()
    }
    
    func XMLParsingExample(){
        var doc: SMXMLDocument?
        var bartTrips = [Trip]()
        var xmlData: NSData?{
            didSet{
                var err: NSError?
                doc = SMXMLDocument(data: xmlData!, error: &err)
                if err == nil{
                    var root = doc!.childrenNamed("schedule")[0] as! SMXMLElement
                    var request = root.childrenNamed("request")[0] as! SMXMLElement
                    var trips = request.childrenNamed("trip") as! [SMXMLElement]
                    for trip in trips{
                        var legs = trip.childrenNamed("leg") as! [SMXMLElement]
                        var newTrip = Trip()
                        for leg in legs{
                            var tripLeg = Leg()
                            tripLeg.destDate = leg.attributeNamed("destTimeDate")
                            tripLeg.destination = leg.attributeNamed("destination")
                            tripLeg.destTimeMin = leg.attributeNamed("destTimeMin")
                            tripLeg.line = leg.attributeNamed("line")
                            tripLeg.order = leg.attributeNamed("order")
                            tripLeg.origDate = leg.attributeNamed("origTimeDate")
                            tripLeg.origin = leg.attributeNamed("origin")
                            tripLeg.origTimeMin = leg.attributeNamed("origTimeMin")
                            newTrip.legs.append(tripLeg)
                        }
                        bartTrips.append(newTrip)
                    }
                    var formatter = NSDateFormatter()
                    formatter.timeZone = NSTimeZone.localTimeZone()
                    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
                    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                    for t in bartTrips{
                        for l in t.legs{
                            t.legs.sort{
                                (a, b) in
                                var a: Int = NSString(string: a.order!).integerValue
                                var b: Int = NSString(string: b.order!).integerValue
                                return a < b
                            }
                            var legDateTime = formatter.dateFromString("\(l.origDate!) \(l.origTimeMin!)")
                            if legDateTime?.timeIntervalSinceNow >= 0{
                                println("-------------------------------------------------------")
                                println("\(l.origin!)-\(l.destination!) at \(l.origDate!) \(l.origTimeMin!)")
                                println("-------------------------------------------------------")
                            }

                        }
                    }
                }
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var data = NSData(contentsOfURL: NSURL(string: "http://api.bart.gov/api/sched.aspx?cmd=depart&orig=ucty&dest=mont&key=MW9S-E7SL-26DU-VV8V")!)!
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                xmlData = data
            })
        })
    }
    
    func JSONParsingExample(){
        var err: NSError?
        
        var serverData: NSData?{
            didSet{
                var json = JSONParser.parse(serverData!, error: &err)
                if let j = json{
                    if let name = j["loans"]?[0]?["name"]?.stringValue{
                        println(name)
                    }
                    if let use = j["loans"]?[0]?["use"]?.stringValue{
                        println(use)
                    }
                    if let loanAmount = j["loans"]?[0]?["loan_amount"]?.intValue{
                        println(loanAmount)
                    }
                }
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var data = NSData(contentsOfURL: NSURL(string: "http://api.kivaws.org/v1/loans/search.json?status=fundraising")!)!
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                serverData = data
            })
        })
        
        
    }
    
    func locationManagerExample(){
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }else{
            println("Please allow for location update")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var lastLocation = locations.last as? CLLocation
        if let location = lastLocation{
            println("location updated to: Lat:\(location.coordinate.latitude), Lng: \(location.coordinate.longitude)")
        }
    }
    
    func emailExample(){
        var email = EmailSharing(username: "Anoop Tomar")
        email.username = "AT"
        var message = Message(sharingMethod: email)
        message.share()
        
        
        
        let (name, age, salary) = email.returnMultipleValues()
        filterArray()
        complexArrayFilter()
        dictionaryDemo()
        println(add(2,3))
        doSomething("Anoop", finished: { () -> Bool in
            println("Job finished")
            return true
        })
        
        println("are two usernames equal?: \(areUserNameEqual(email, b: email))")
    }
    
    func downloadFileOverNetwork(){
        var url = "http://www.brainloaf.com/introduction-to-ios.mp4"
        var configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("sessionDownload")
        configuration.sessionSendsLaunchEvents = true
        configuration.discretionary = true
        
        var session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        var task = session.downloadTaskWithURL(NSURL(string: url)!)
        task.resume()
    }
    
    // MARK: NSURLSessionDownload related functions
    
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        println("Session is invalid: \(error?.localizedDescription)")
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        println("Temporary path: \(location)")
        var fileManager = NSFileManager()
        var err: NSError?
        
        var dest = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first?.stringByAppendingString("/introduction-to-ios.mp4") as String!
        if fileManager.moveItemAtURL(location, toURL: NSURL(fileURLWithPath: dest!)!, error: &err){
            println("File downloaded to \(dest!)")
        }else{
            println("Failed to save \(err?.localizedDescription)")
        }
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.myprogressView.setProgress((Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)), animated: true)
        })
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            println("Download complete!")
        }else{
            println("Download completed with error \(error)")
        }
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let complete = appDelegate.completionHandler{
            complete()
            appDelegate.completionHandler = nil
        }
    }
    
    // MARK: End NSURLSession
    
    func nsOperationQueueExample(){
        mainQueue = NSOperationQueue.mainQueue()
        serialQueue = NSOperationQueue()
        serialQueue?.maxConcurrentOperationCount = 1
        
        serialQueue?.addOperationWithBlock({ () -> Void in
            self.mainQueue?.addOperationWithBlock({ () -> Void in
                self.myprogressView.setProgress(0.0, animated: false)
            })
            
            for i in 1...1000000{
                self.mainQueue?.addOperationWithBlock({ () -> Void in
                    
                        var done = Float(i/100000)
                        self.myprogressView.setProgress(done, animated: true)
                    
                })
            }
        })
    }
    
    
    func gcdExample(){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            self.longRunningTask()
        })
    }
    
    func longRunningTask(){
        sleep(10)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.textb.text = "Hello after 10 seconds of delay :P"
        })
    }
    
    func threadingExample(){
        var myInstance = MyThreadClass()
        
        NSThread.detachNewThreadSelector("threadMethod:", toTarget: myInstance, withObject: myInstance)
        
        var thread = NSThread(target: myInstance, selector: "threadMethod:", object: myInstance)
        thread.stackSize = 16000
        thread.threadPriority = 0.75
        thread.start()
        
    }
    
    func demoStack(){
        var stack = ATStack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
        stack.push(5)
        while(!stack.isEmpty()){
            println(stack.pop()!)
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "liftMainViewWhenKeyboardAppear:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "returnMainViewWhenKeyboardAppear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    @IBAction func sendMessage(sender: UIButton) {
        loginAlertController()
    }
    
    func loginAlertController(){
        var loginField: UITextField!
        var passwordField: UITextField!
        
        let loginAlert = UIAlertController(title: "Login", message: "Please enter your credentials", preferredStyle: UIAlertControllerStyle.Alert)
        loginAlert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Username"
            loginField = textField
        }
        
        loginAlert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
            passwordField = textField
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            println("Username: \(loginField.text!) Password: \(passwordField.text!)")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction!) -> Void in
            println("login cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        loginAlert.addAction(okAction)
        loginAlert.addAction(cancelAction)
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    func testAlertController(){
        let baconController = UIAlertController(title: "Bacon Alert", message: "Who wants bacon.. yum yum yum...", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        let noMoreAction = UIAlertAction(title: "No More PLEASE!!!", style: UIAlertActionStyle.Destructive, handler: nil)
        baconController.addAction(cancelAction)
        baconController.addAction(okAction)
        baconController.addAction(noMoreAction)
        self.presentViewController(baconController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func liftMainViewWhenKeyboardAppear(aNotification: NSNotification){
        var userInfo: NSDictionary = aNotification.userInfo!
        var animationDuration = NSTimeInterval()
        var animationCurve = UIViewAnimationCurve(rawValue: 0)
        var keyboardFrame = CGRect()
        
        userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.getValue(&animationCurve)
        userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.getValue(&animationDuration)
        userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)?.getValue(&keyboardFrame)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(animationCurve!)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height - keyboardFrame.size.height)
        UIView.commitAnimations()
    }
    
    func returnMainViewWhenKeyboardAppear(aNotification: NSNotification){
        var userInfo: NSDictionary = aNotification.userInfo!
        var animationDuration = NSTimeInterval()
        var animationCurve = UIViewAnimationCurve(rawValue: 0)
        var keyboardFrame = CGRect()
        
        userInfo.objectForKey(UIKeyboardAnimationDurationUserInfoKey)?.getValue(&animationDuration)
        userInfo.objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.getValue(&animationCurve)
        userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)?.getValue(&keyboardFrame)
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        UIView.setAnimationCurve(animationCurve!)
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.width, self.view.frame.height + keyboardFrame.size.height)
        UIView.commitAnimations()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func doSomething(name: String, finished: ()-> Bool){
        println("\(name) do something")
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func filterArray(){
        var vehicles = ["Car", "Bus", "Truck", "Plane"]
        println(vehicles.filter({c in c == "Car" || c == "Truck"}))
    }
    
    func complexArrayFilter(){
        // complex array exmaple
        var complexArray = [
            Vehicle(name: "Honda Accord", year: 2013, numberOfWheels: 4),
            Vehicle(name: "Vespa", year: 1998, numberOfWheels: 2),
            Vehicle(name: "Mayflower Truck", year: 2000, numberOfWheels: 6),
            Vehicle(name: "Tempo", year: 1988, numberOfWheels: 3)
            ]
        // map and filter example on array
        println(complexArray.filter({ v in v.year >= 2000 }).map({v in v.name}))
        // in place sort example on complex array
        complexArray.sort({$0.year < $1.year})
        println(complexArray.map({v in "\(v.name) \(v.year)"}))
        
        // replace example using range in complex array
        complexArray[2...2] = [Vehicle(name: "TwoSitter", year: 1999, numberOfWheels: 3)]
        println(complexArray.map({v in "\(v.name) \(v.year)"}))
        
        // example of subscript
        var vehicle = Vehicle(name: "Car", year: 1990, numberOfWheels: 4)
        vehicle.similarVehicles = [Vehicle(name: "Honda Accord", year: 2013, numberOfWheels: 4), Vehicle(name: "Toyota Corola", year: 2000, numberOfWheels: 4), Vehicle(name: "Honda Civic", year: 2015, numberOfWheels: 4)]
        println(vehicle["Honda"].map({v in v.name}))
    }
    
    func dictionaryDemo(){
        var dictionary = Dictionary<Int, String>()
        dictionary[1] = "First"
        dictionary[2] = "Second"
        dictionary[3] = "Third"
        
        for (k, v) in dictionary{
            println("key is \(k) value is \(v)")
        }
    }
    
    
    func areUserNameEqual<T: Sharing>(a: T, b: T) -> Bool{
        return a.username == b.username
    }
}

class Vehicle{
    var name: String
    var year: Int
    var numberOfWheels: Int
    var similarVehicles = [Vehicle]()
    
    init(name: String, year: Int, numberOfWheels: Int){
        self.name = name
        self.year = year
        self.numberOfWheels = numberOfWheels
    }
    
    // example of subscript
    subscript(name: String) -> [Vehicle]{
        return similarVehicles.filter(){
            s in s.name.rangeOfString(name, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) != nil
        }
    }
    
}

class EmailSharing: Sharing{
    private var _error: String?
    var username: String{
        willSet(newUsername){
            println("new username is going to set to \(newUsername)")
        }
        didSet(oldValue){
            println("old value is \(oldValue)")
        }
    }
    
    enum Measure{
        case Cup(Double), Tablespoon(Double), Ounce(Double)
        
        func description() -> String{
            switch(self){
            case .Cup(let value):
                return "Cup's value is \(value)"
            case .Ounce(let value):
                return "Ounce's value is \(value)"
            case .Tablespoon(let value):
                return "Tablespoon's value is \(value)"
            }
        }
        
        func convertToOunces() -> Measure{
            switch(self){
            case .Cup(let value):
                return Ounce(value * 0.8)
            case .Tablespoon(let value):
                return Ounce(value * 0.5)
            default:
                return self
            }
        }
        
    }
    
    var amount = Measure.Cup(2.5)
    
    var error: String?{
        return _error
    }
    
    init(username: String){
        self.username = username
    }
    
    func shareMessage(message: String) -> Bool {
        println("Message from \(username): \n\(message)")
        println(amount.convertToOunces().description())
        return true
    }
    
    func returnMultipleValues() -> (name: String, age: Int, salary: Double){
        return(name: "Anoop", age: 34, salary: 349.0)
    }
}

class Message{
    var sharingMethod: Sharing
    var message = "Hola mundo!"
    
    init(sharingMethod: Sharing){
        self.sharingMethod = sharingMethod
    }
    
    func share(){
        sharingMethod.shareMessage(message)
    }
}

@objc class MyThreadClass{
    func threadMethod(object: AnyObject?){
        var j = 0
        for i in 1..<10{
            objc_sync_enter(object)
            println("iteration #\(i)")
            objc_sync_exit(object)
        }
    }
}
