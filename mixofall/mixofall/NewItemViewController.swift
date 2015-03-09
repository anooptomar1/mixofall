//
//  NewItemViewController.swift
//  mixofall
//
//  Created by Anoop tomar on 3/8/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class NewItemViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var newItem: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.newItem.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addItem(sender: UIButton) {
        toDoList.append(newItem.text)
        newItem.text = ""
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: kTodoList)
    }
   
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}
