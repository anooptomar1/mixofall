//
//  TableDemo1ViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/9/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class TableDemo1ViewController: UIViewController {
    
    let CELL_IDENTIFIER = "identifier"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableDemo1ViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = self.tableView.dequeueReusableCellWithIdentifier(CELL_IDENTIFIER) as? UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: CELL_IDENTIFIER)
        }
        cell!.textLabel!.text = "Ba ba ba ... ba ba bare"
        cell!.detailTextLabel!.text = "Ba ba ba"
        return cell!
    }

}

extension TableDemo1ViewController: UITableViewDelegate{}
