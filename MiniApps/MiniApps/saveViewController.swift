//
//  saveViewController.swift
//  MiniApps
//
//  Created by Anoop tomar on 8/31/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

protocol saveViewControllerDelegate: class{
    func didSaved(sa: saveViewController, note: String)
}

class saveViewController: UIViewController {

    @IBOutlet weak var noteText: UITextField!
    weak var delegate: saveViewControllerDelegate?
    
    var sourceVC: TodoViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onSave(sender: UIBarButtonItem) {
        self.delegate?.didSaved(self, note: noteText.text)
        navigationController?.popToViewController(sourceVC!, animated: true)
    }
}
