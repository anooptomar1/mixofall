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
        items.append(MenuItem(name: "Audio Streaming Player", storyboard: "streamingPlayer", id: 2))
        items.append(MenuItem(name: "System Sound Service", storyboard: "SSS", id: 3))
        items.append(MenuItem(name: "OAuth 2.0 Test", storyboard: "OAuth2Test", id: 4))
        items.append(MenuItem(name: "Networking basics", storyboard: "NetworkingTest", id: 5))
    }
}