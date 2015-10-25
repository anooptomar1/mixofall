//
//  MenuItem.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/23/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

public class MenuItem{
    private let _name: String
    private let _storyboard: String
    private let _id: Int
    
    var Name: String{
        return _name
    }
    
    var Storyboard: String{
        return _storyboard
    }
    
    var Id: Int{
        return _id
    }
    
    init(name: String, storyboard: String, id: Int){
        _name = name
        _storyboard = storyboard
        _id = id
    }
}