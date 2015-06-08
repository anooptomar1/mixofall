//
//  AlarmDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 6/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import EventKit

class AlarmDemoViewController: UIViewController {

    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var eventStore: EKEventStore?
    var appDelegate: AppDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createReminder(){
        let reminder = EKReminder(eventStore: appDelegate!.eventStore!)
        reminder.title = reminderText!.text!
        reminder.calendar = appDelegate!.eventStore!.defaultCalendarForNewReminders()
        let date = datePicker.date
        let alarm = EKAlarm(absoluteDate: date)
        
        reminder.addAlarm(alarm)
        var error: NSError?
        appDelegate!.eventStore!.saveReminder(reminder, commit: true, error: &error)
        if error != nil{
            println("Reminder failed with error: \(error?.localizedDescription)")
        }
    }
    
    @IBAction func onReminder(sender: UIButton) {
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        if appDelegate!.eventStore == nil{
            appDelegate!.eventStore = EKEventStore()
            appDelegate!.eventStore?.requestAccessToEntityType(EKEntityTypeReminder, completion: { (granted: Bool, error: NSError!) -> Void in
                if !granted{
                    println("Access to store not granted")
                }else{
                    println("Access granted")
                }
            })
        }
        
        if appDelegate!.eventStore != nil{
            self.createReminder()
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        reminderText.endEditing(true)
    }
}
