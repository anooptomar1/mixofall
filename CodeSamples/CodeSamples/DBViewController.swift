//
//  DBViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/14/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class DBViewController: UIViewController {

    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
   
    var databasePath = NSString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNCreateDatabase()
    }
    
    // check if db and table needs to be created
    func checkNCreateDatabase(){
        let fileManager = NSFileManager.defaultManager()
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = dirPath[0] as! String
        databasePath = docDir.stringByAppendingPathComponent("contacts.db")
        
        if !fileManager.fileExistsAtPath(databasePath as! String){
            let contactDB = FMDatabase(path: databasePath as! String)
            if contactDB == nil{
                println("Error: \(contactDB.lastErrorMessage())")
            }
            if contactDB.open(){
                let sql_stmt = "CREATE TABLE IF NOT EXISTS CONTACTS(ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                if !contactDB.executeStatements(sql_stmt){
                    println("Error: \(contactDB.lastErrorMessage())")
                }
                contactDB.close()
            }else{
                println("Error: \(contactDB.lastErrorMessage())")
            }
        }
    }

    // insert new contact into the database table
    @IBAction func onSave(sender: UIButton) {
        let contactDB = FMDatabase(path: databasePath as! String)
        
        if(contactDB.open()){
            let insertSql = "INSERT INTO CONTACTS (name, address, phone) VALUES('\(nameTxt.text!)', '\(addressTxt.text!)', '\(phoneTxt.text!)')"
            let result = contactDB.executeUpdate(insertSql, withArgumentsInArray: nil)
            if !result{
                statusLabel.text = "Failed to add contact"
                println("Error: \(contactDB.lastErrorMessage())")
            }else{
                statusLabel.text = "Contact Added"
                nameTxt.text = ""
                addressTxt.text = ""
                phoneTxt.text = ""
            }
        }else{
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }
   
    // query database and find the table
    @IBAction func onFind(sender: UIButton) {
        let contactDB = FMDatabase(path: databasePath as! String)
        if contactDB.open(){
            let querySql = "SELECT address, phone FROM CONTACTS WHERE name = '\(nameTxt.text!)'"
            let result = contactDB.executeQuery(querySql, withArgumentsInArray: nil)
            
            if result.next() == true{
                addressTxt.text = result.stringForColumn("address")
                phoneTxt.text = result.stringForColumn("phone")
                statusLabel.text = "Record found"
            }else{
                statusLabel.text = "Record not found"
                addressTxt.text = ""
                phoneTxt.text = ""
            }
        }else{
            println("Error: \(contactDB.lastErrorMessage())")
        }
    }

}


















