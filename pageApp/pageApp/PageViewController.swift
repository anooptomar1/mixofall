//
//  ViewController.swift
//  pageApp
//
//  Created by Anoop tomar on 4/7/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    
    var pageController: UIPageViewController?
    var pageContent = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPageContent()
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        
        pageController?.dataSource = self
        pageController?.delegate = self
        
        let firstVC:ContentViewController = viewControllerAtIndex(0)!
        let secondVC: ContentViewController = viewControllerAtIndex(1)!
        
        pageController?.setViewControllers([firstVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.addChildViewController(pageController!)
        self.view.addSubview(self.pageController!.view)
        
        var pageViewRect = self.view.bounds
        pageController!.view.frame = pageViewRect
        pageController!.didMoveToParentViewController(self)
    }
    
    func createPageContent(){
        var pageStrings = [String]()
        
        for i in 1...11{
            let contentString = "<html><head></head><body><br><h1>Chapter \(i)</h1> <p>This is the page \(i) of content displayed using UIPageViewController in iOS 8. </p></body></html>"
            pageStrings.append(contentString)
        }
        
        pageContent = pageStrings
    }
    
    func viewControllerAtIndex(index: Int) -> ContentViewController?{
        if(pageContent.count == 0 || index >= pageContent.count){
            return nil
        }
        let contentVC = self.storyboard?.instantiateViewControllerWithIdentifier("contentView") as! ContentViewController
        contentVC.dataObject = pageContent[index]
        return contentVC
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int{
        if let dataObj: AnyObject = viewController.dataObject{
            return pageContent.indexOfObject(dataObj)
        }else{
            return NSNotFound
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource{
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        if index == 0 || index == NSNotFound{
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! ContentViewController)
        if index == NSNotFound{
            return nil
        }
        
        index++
        
        if index == pageContent.count{
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
}

extension PageViewController: UIPageViewControllerDelegate{}
