//
//  MenuModel.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 10/23/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import Foundation
public class MenuModel {
    private static var items: [MenuItem] = []
    public static func getMenuItems() -> [MenuItem]{
        buildMenuItems()
        return items
    }
    
    private static func buildMenuItems(){
        items.append(MenuItem(name: "Keyboard Scrollview Autosize", storyboard: "keyboardScroll", id: 0))
        items.append(MenuItem(name: "TableView Checkbox", storyboard: "tableviewCB", id: 1))
    }
}