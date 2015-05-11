//
//  TableDemo1ViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/9/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

//import UIKit
//
//class TableDemo1ViewController: UIViewController {
//
//    var tableView: UITableView!
//    let identifier = "IDENTITY"
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height), style: UITableViewStyle.Plain)
//        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
//        
//        self.view.addSubview(tableView)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//}
//
//extension TableDemo1ViewController: UITableViewDataSource{
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
//
//        if cell == nil{
//            cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: identifier) as UITableViewCell
//        }
//        
//        cell!.textLabel!.text = "HEADING : \(indexPath.row)"
//        cell!.detailTextLabel!.text = "Details \(indexPath.row)"
//        
//        return cell!
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    
//}
//
//extension TableDemo1ViewController: UITableViewDelegate{}
