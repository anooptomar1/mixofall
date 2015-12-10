//
//  WalkthroughPageViewController.swift
//  StackOverFlowAnswers
//
//  Created by Anoop tomar on 12/8/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController {

    var pageHeadings = ["Personalize", "Locate", "Discover"]
    var pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    var pageContent = ["Pin your favorite restaurants and create your own food guide", "Search and locate your favourite restaurant on Maps", "Find restaurants pinned by your friends and other foodies around the world"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let startingViewController = viewControllerAtIndex(0){
            setViewControllers([startingViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    func forward(index: Int){
        if let newVC = viewControllerAtIndex(index + 1){
            setViewControllers([newVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        }
    }
    
    func viewControllerAtIndex(index: Int) -> WalkthroughContentViewController?{
        if index == NSNotFound || index < 0 || index >= pageHeadings.count{
            return nil
        }
        if let pageContentViewController = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentController") as? WalkthroughContentViewController{
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.footer = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index--
        return viewControllerAtIndex(index)
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentViewController).index
        index++
        return viewControllerAtIndex(index)
    }
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return pageHeadings.count
//    }
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        if let page = storyboard?.instantiateViewControllerWithIdentifier("WalkthroughContentController") as? WalkthroughContentViewController{
//            return page.index
//        }
//        return 0
//    }
}
