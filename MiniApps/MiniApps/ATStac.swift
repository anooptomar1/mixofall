//
//  ATStac.swift
//  MiniApps
//
//  Created by Anoop tomar on 7/24/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class ATStack<T> {
    var head: Node<T>?
    var counter = 0
    
    func push(da: T){
        let newNode = createNewNode(da)
        if(head == nil){
            head = newNode
            counter++
            return
        }
        
        let temp = head
        newNode.next = temp
        head = newNode
        counter++
    }
    
    func pop() ->T? {
        if(isEmpty()){
            return nil
        }
        let temp = head
        head = temp!.next
        counter--
        return temp?.data
    }
    
    func isEmpty() -> Bool{
        return counter <= 0
    }
    
    private func createNewNode(da: T) -> Node<T>{
        let node = Node<T>()
        node.data = da
        return node
    }
}

class Node<T>{
    var data:T?
    var next: Node?
}