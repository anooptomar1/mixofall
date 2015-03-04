//
//  TaskList.swift
//  taskList
//
//  Created by Anoop tomar on 3/2/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

let taskListDidChangeNotification = "MyTaskListDidChange"

class TaskList{
    var _name:String{
        didSet{
            postNotification()
        }
    }
    var _location: String{
        didSet{
            postNotification()
        }
    }
    
    var _taskImage: UIImage{
        didSet{
            postNotification()
        }
    }
    
    init(name: String, location: String){
        self._name = name
        self._location = location
        self._taskImage = UIImage(named: "two185")!
    }
    
    func postNotification(){
        let center = NSNotificationCenter.defaultCenter()
        center.postNotificationName(taskListDidChangeNotification, object: self)
    }
}
