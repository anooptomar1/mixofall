//
//  FileMgrViewController.swift
//  pageApp
//
//  Created by Anoop tomar on 4/11/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class FileMgrViewController: UIViewController {

    @IBOutlet weak var textBox: UITextField!
    
    var fileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dirPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        docsDir = dirPath[0] as? String
        dataFile = docsDir?.stringByAppendingPathComponent("datafile.dat")
        
        if fileManager.fileExistsAtPath(dataFile!){
            let dataBuffer = fileManager.contentsAtPath(dataFile!)
            var dataString = NSString(data: dataBuffer!, encoding: NSUTF8StringEncoding)
            textBox.text = dataString! as String
        }
    }

   
    @IBAction func onSave(sender: UIButton) {
        let dataBuffer = (textBox.text as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        println(fileManager.createFileAtPath(dataFile!, contents: dataBuffer, attributes: nil))
    }

}
