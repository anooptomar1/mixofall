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
import CoreData

class CTViewController: UIViewController, NSURLSessionDownloadDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var myprogressView: UIProgressView!
    var serialQueue: NSOperationQueue?
    var mainQueue: NSOperationQueue?
    var reach: Reachability!
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var textb: UITextField!
    var add = {(a: Int, b: Int) -> Int in return a + b}

    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataExample()
    }
    
    func CoreDataExample(){
        let helper = CoreDataHelper(modelName: "MiniApps", datastoreFileName: "MiniApps.sqlite")
        let coordinator = helper.persistentStoreCoordinator
        let recipe = helper.newEntry("Recipe") as? Recipe
        if let r = recipe{
            r.name = "Apple pie"
            r.serves = 8
            r.recipeDescription = "A summer tradition"
            helper.saveContext()
        }
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Recipe", inManagedObjectContext: helper.managedObjectContext!)
        fetchRequest.entity = entity
        
        var error: NSError?
        
       // let result = helper.managedObjectContext?.executeFetchRequest(fetchRequest) as? [Recipe]
//        if let recepies = result{
//            for r in recepies{
//                print(r.name)
//            }
//        }
    }
    
    func RestClientExample(){
        RestClient.Get("https://openlibrary.org/books/OL8365328M.json", callback: { (json: JSON?, error: NSError?) -> () in
            if let err = error{
                print("Error: \(err.localizedDescription)")
                return
            }
            
            if let j = json{
                let subtitle = j["subtitle"]?.stringValue
                let title = j["title"]?.stringValue
                let revision = j["revision"]?.intValue
                print("Title: \(title!) - \(subtitle!)")
                print("Revision: \(revision!)")
            }
        })
        let data: [String: AnyObject] = [ "name" : "PeaSoup","Ingredients" : "Split Peas, Water, Chicken Broth, Milk, Salt, Onions" ]
        RestClient.Post("http://echo.jsontest.com/status/OK", data: data) { (json: JSON?, error: NSError?) -> () in
            if let err = error{
                print(err.localizedDescription)
            }
            if let j = json{
                print((j["status"]?.stringValue)!)
            }
        }
    }
    
    func reachabilityTest(){
        reach = Reachability.reachabilityForInternetConnection()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "checkForReachability:", name: kReachabilityChangedNotification, object: nil)
        reach.startNotifier()
    }
    
    func checkForReachability(notification: NSNotification){
        switch reach.currentReachabilityStatus().rawValue{
        case ReachableViaWiFi.rawValue:
            print("Reachable via wifi")
        case ReachableViaWWAN.rawValue:
            print("Reachable via mobile network")
        case NotReachable.rawValue:
            print("Not reachable")
        default:
            print("Not reachable")
        }
    }
    
    
    func XMLParsingExample(){
        var doc: SMXMLDocument?
        var bartTrips = [Trip]()
        var xmlData: NSData?{
            didSet{
                var err: NSError?
                do {
                    doc = try SMXMLDocument(data: xmlData!)
                } catch let error as NSError {
                    err = error
                    doc = nil
                }
                if err == nil{
                    let root = doc!.childrenNamed("schedule")[0] as! SMXMLElement
                    let request = root.childrenNamed("request")[0] as! SMXMLElement
                    let trips = request.childrenNamed("trip") as! [SMXMLElement]
                    for trip in trips{
                        let legs = trip.childrenNamed("leg") as! [SMXMLElement]
                        let newTrip = Trip()
                        for leg in legs{
                            let tripLeg = Leg()
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
                    let formatter = NSDateFormatter()
                    formatter.timeZone = NSTimeZone.localTimeZone()
                    formatter.timeStyle = NSDateFormatterStyle.ShortStyle
                    formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                    for t in bartTrips{
                        for l in t.legs{
                            t.legs.sortInPlace{
                                (a, b) in
                                let a: Int = NSString(string: a.order!).integerValue
                                let b: Int = NSString(string: b.order!).integerValue
                                return a < b
                            }
                            let legDateTime = formatter.dateFromString("\(l.origDate!) \(l.origTimeMin!)")
                            if legDateTime?.timeIntervalSinceNow >= 0{
                                print("-------------------------------------------------------")
                                print("\(l.origin!)-\(l.destination!) at \(l.origDate!) \(l.origTimeMin!)")
                                print("-------------------------------------------------------")
                            }

                        }
                    }
                }
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let data = NSData(contentsOfURL: NSURL(string: "http://api.bart.gov/api/sched.aspx?cmd=depart&orig=ucty&dest=mont&key=MW9S-E7SL-26DU-VV8V")!)!
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                xmlData = data
            })
        })
    }
    
    func JSONParsingExample(){
        var err: NSError?
        
        var serverData: NSData?{
            didSet{
                var json: JSON?
                do {
                    json = try JSONParser.parse(serverData!)
                } catch var error as NSError {
                    err = error
                    json = nil
                }
                if let j = json{
                    if let name = j["loans"]?[0]?["name"]?.stringValue{
                        print(name)
                    }
                    if let use = j["loans"]?[0]?["use"]?.stringValue{
                        print(use)
                    }
                    if let loanAmount = j["loans"]?[0]?["loan_amount"]?.intValue{
                        print(loanAmount)
                    }
                }
            }
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            let data = NSData(contentsOfURL: NSURL(string: "http://api.kivaws.org/v1/loans/search.json?status=fundraising")!)!
            
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
            print("Please allow for location update")
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var lastLocation = locations.last as CLLocation?
        if let location = lastLocation{
            print("location updated to: Lat:\(location.coordinate.latitude), Lng: \(location.coordinate.longitude)")
        }
    }
    
    func emailExample(){
        let email = EmailSharing(username: "Anoop Tomar")
        email.username = "AT"
        let message = Message(sharingMethod: email)
        message.share()
        
        
        
        let (name, age, salary) = email.returnMultipleValues()
        filterArray()
        complexArrayFilter()
        dictionaryDemo()
        print(add(2,3))
        doSomething("Anoop", finished: { () -> Bool in
            print("Job finished")
            return true
        })
        
        print("are two usernames equal?: \(areUserNameEqual(email, b: email))")
    }
    
    func downloadFileOverNetwork(){
        let url = "http://www.brainloaf.com/introduction-to-ios.mp4"
        let configuration = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier("sessionDownload")
        configuration.sessionSendsLaunchEvents = true
        configuration.discretionary = true
        
        let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.downloadTaskWithURL(NSURL(string: url)!)
        task.resume()
    }
    
    // MARK: NSURLSessionDownload related functions
    
    func URLSession(session: NSURLSession, didBecomeInvalidWithError error: NSError?) {
        print("Session is invalid: \(error?.localizedDescription)")
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        print("Temporary path: \(location)")
        var fileManager = NSFileManager()
        var err: NSError?
        
        var dest = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first?.stringByAppendingString("/introduction-to-ios.mp4") as String!
        do {
            try fileManager.moveItemAtURL(location, toURL: NSURL(fileURLWithPath: dest!))
            print("File downloaded to \(dest!)")
        } catch var error as NSError {
            err = error
            print("Failed to save \(err?.localizedDescription)")
        }
        
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.myprogressView.setProgress((Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)), animated: true)
        })
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error == nil{
            print("Download complete!")
        }else{
            print("Download completed with error \(error)")
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
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
                    
                        let done = Float(i/100000)
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
        let myInstance = MyThreadClass()
        
        NSThread.detachNewThreadSelector("threadMethod:", toTarget: myInstance, withObject: myInstance)
        
        let thread = NSThread(target: myInstance, selector: "threadMethod:", object: myInstance)
        thread.stackSize = 16000
        thread.threadPriority = 0.75
        thread.start()
        
    }
    
    func demoStack(){
        let stack = ATStack<Int>()
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
        stack.push(5)
        while(!stack.isEmpty()){
            print(stack.pop()!)
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
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("Username: \(loginField.text!) Password: \(passwordField.text!)")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction) -> Void in
            print("login cancelled")
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func liftMainViewWhenKeyboardAppear(aNotification: NSNotification){
        let userInfo: NSDictionary = aNotification.userInfo!
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
        let userInfo: NSDictionary = aNotification.userInfo!
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
        print("\(name) do something")
    }
    
    @IBAction func onClose(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func filterArray(){
        let vehicles = ["Car", "Bus", "Truck", "Plane"]
        print(vehicles.filter({c in c == "Car" || c == "Truck"}))
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
        print(complexArray.filter({ v in v.year >= 2000 }).map({v in v.name}))
        // in place sort example on complex array
        complexArray.sortInPlace({$0.year < $1.year})
        print(complexArray.map({v in "\(v.name) \(v.year)"}))
        
        // replace example using range in complex array
        complexArray[2...2] = [Vehicle(name: "TwoSitter", year: 1999, numberOfWheels: 3)]
        print(complexArray.map({v in "\(v.name) \(v.year)"}))
        
        // example of subscript
        let vehicle = Vehicle(name: "Car", year: 1990, numberOfWheels: 4)
        vehicle.similarVehicles = [Vehicle(name: "Honda Accord", year: 2013, numberOfWheels: 4), Vehicle(name: "Toyota Corola", year: 2000, numberOfWheels: 4), Vehicle(name: "Honda Civic", year: 2015, numberOfWheels: 4)]
        print(vehicle["Honda"].map({v in v.name}))
    }
    
    func dictionaryDemo(){
        var dictionary = Dictionary<Int, String>()
        dictionary[1] = "First"
        dictionary[2] = "Second"
        dictionary[3] = "Third"
        
        for (k, v) in dictionary{
            print("key is \(k) value is \(v)")
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
            print("new username is going to set to \(newUsername)")
        }
        didSet(oldValue){
            print("old value is \(oldValue)")
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
        print("Message from \(username): \n\(message)")
        print(amount.convertToOunces().description())
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

class MyThreadClass{
    func threadMethod(object: AnyObject?){
        var j = 0
        for i in 1..<10{
            objc_sync_enter(object)
            print("iteration #\(i)")
            objc_sync_exit(object)
        }
    }
}
