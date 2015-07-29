//
//  ABAppViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit
import AddressBook

class ABAppViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var phoneDictionary = [AddressBookPeople]()
    
    lazy var addressBook: ABAddressBookRef = {
        var error: Unmanaged<CFError>?
        return ABAddressBookCreateWithOptions(nil, &error).takeUnretainedValue() as ABAddressBookRef
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askForAddressBookPermissions()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func askForAddressBookPermissions(){
        switch ABAddressBookGetAuthorizationStatus(){
        case ABAuthorizationStatus.Authorized:
            //println("AddressBook access authorized")
            self.readFromAddressBook(addressBook)
            
        case ABAuthorizationStatus.Denied:
            println("AddressBook permission denied")
            
        case ABAuthorizationStatus.NotDetermined:
            println("AddressBook permissions not determined")
            ABAddressBookRequestAccessWithCompletion(addressBook, { [weak self] (granted: Bool, error: CFError!) in
                if granted{
                    let strongSelf = self!
                    strongSelf.readFromAddressBook(strongSelf.addressBook)
                    println("Access granted")
                }else{
                    println("Access denied")
                }
            })
        case ABAuthorizationStatus.Restricted:
            println("Access is restricted")
            
        default:
            println("Unhandled")
        }
        
        
    }
    
    @IBAction func onClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func readFromAddressBook(addressBook: ABAddressBookRef){
        let allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook).takeUnretainedValue() as NSArray
        for person: ABRecordRef in allPeople{
            if let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty) {
                if let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty) {
                    let multi = ABRecordCopyValue(person, kABPersonPhoneProperty)
                    
                    let unmanagedPhones = ABRecordCopyValue(person, kABPersonPhoneProperty)
                    let phones: ABMultiValueRef =
                    Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeUnretainedValue()
                        as NSObject as ABMultiValueRef
                    
                    let countOfPhones = ABMultiValueGetCount(phones)
                    var phone: String = ""
                    
                    for index in 0..<countOfPhones{
                        let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                        phone += Unmanaged.fromOpaque(
                            unmanagedPhone.toOpaque()).takeUnretainedValue() as NSObject as! String
                        phone += " "
                    }
                    let fName = Unmanaged.fromOpaque(firstName.toOpaque()).takeUnretainedValue() as NSObject as! String
                    let lName = Unmanaged.fromOpaque(lastName.toOpaque()).takeUnretainedValue() as NSObject as! String
                    phoneDictionary.append(AddressBookPeople(personName: "\(fName) \(lName)", personPhone: phone))
                }
                
            }
//            let firstName = Unmanaged.fromOpaque(ABRecordCopyValue(person, kABPersonFirstNameProperty).toOpaque()).takeUnretainedValue() as NSObject as? String
//            let lastName = Unmanaged.fromOpaque(ABRecordCopyValue(person, kABPersonLastNameProperty).toOpaque()).takeUnretainedValue() as NSObject as? String
            
        }
    }
}

extension ABAppViewController: UITableViewDelegate{}

extension ABAppViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        var aPerson = phoneDictionary[indexPath.row]
        cell!.textLabel!.text = aPerson.name
        cell!.detailTextLabel!.text = aPerson.phone
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneDictionary.count
    }
}

