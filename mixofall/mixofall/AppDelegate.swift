//
//  AppDelegate.swift
//  mixofall
//
//  Created by Anoop tomar on 2/26/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        weatherDemoStartup()
        return true
    }
    
    func weatherDemoStartup(){
        //var nav = UINavigationController(rootViewController: UIStoryboard(name: "weatherSB", bundle: nil).instantiateViewControllerWithIdentifier("weatherVC") as WeatherViewController)
        self.window?.rootViewController = UIStoryboard(name: "weatherSB", bundle: nil).instantiateViewControllerWithIdentifier("weatherVC") as WeatherViewController
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        UIApplication.sharedApplication().statusBarHidden = false
    }
    
    func mapDemoStartup(){
        var nav = UINavigationController(rootViewController: UIStoryboard(name: "mapsSB", bundle: nil).instantiateViewControllerWithIdentifier("photoVC") as PhotoViewController)
        
        self.window?.rootViewController = nav
    }

    func TabBarStartUP(){
        var toDoStoryBoard = UIStoryboard(name: "ToDoSB", bundle: nil)
        
        var mainViewController = UINavigationController(rootViewController: toDoStoryBoard.instantiateViewControllerWithIdentifier("MainVC") as MainViewController)
        var addNewViewController = UINavigationController(rootViewController: toDoStoryBoard.instantiateViewControllerWithIdentifier("NewItemVC") as NewItemViewController)
        
        var listTabItem = UITabBarItem(title: "List", image: UIImage(named: "clipboard109"), tag: 0)
        
        
        mainViewController.tabBarItem = listTabItem
        
        addNewViewController.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named: "add10"), tag: 1)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [mainViewController, addNewViewController]
        
        self.window?.rootViewController = tabBarController

    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

