//
//  ViewController.swift
//  DSA
//
//  Created by Anoop tomar on 10/19/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

enum AlgoType: Int{

    case InsertionSort = 0, BubbleSort, QuickSort, MergeSort, SelectionSort
    
    var desciption: String{
        switch self{
        case .InsertionSort:
            return "InsertionSort"
        case .BubbleSort:
            return "BubbleSort"
        case .QuickSort:
            return "QuickSort"
        case .MergeSort:
            return "MergeSort"
        case .SelectionSort:
            return "SelectionSort"
        }
    }
    
}

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "sortDetails"{
            let vc = segue.destinationViewController as! SortingViewController
            let idxPath = tableview.indexPathForSelectedRow
            if([0, 1, 2, 3, 4].contains(idxPath!.row)){
               vc.algoType = AlgoType(rawValue: idxPath!.row)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        if([0, 1, 2, 3, 4].contains(indexPath.row)){
            cell!.textLabel!.text = AlgoType(rawValue: indexPath.row)!.desciption
        }else{
            cell!.textLabel!.text = "Row \(indexPath.row)"
        }
        
        return cell!
    }
}

