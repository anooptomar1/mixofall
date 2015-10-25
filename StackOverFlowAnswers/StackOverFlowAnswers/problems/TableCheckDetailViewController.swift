//
//  TableCheckDetailViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/24/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TableCheckDetailViewController: UIViewController {

    
    @IBOutlet weak var textView: UITextView!
    var selectedItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedItems.count > 0{
            var textToShow = ""
            for item in selectedItems{
                textToShow += "\(item) \n"
            }
            textView.text = textToShow
        }
    }

    
}
