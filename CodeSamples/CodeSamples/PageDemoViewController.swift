//
//  PageDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/10/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class PageDemoViewController: UIViewController {
    
    var pageController: UIPageViewController?
    var pageContent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageContent()
        pageController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Vertical, options: nil)
        pageController?.dataSource = self
        pageController?.delegate = self
        var startPage: ContentViewController = ViewAtIndex(0)!
        pageController!.setViewControllers([startPage], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        self.addChildViewController(pageController!)
        self.view.addSubview(self.pageController!.view)
        var pageViewRect = self.view.bounds.rectByInsetting(dx: 0, dy: self.navigationController!.navigationBar.frame.height)
        pageController!.view.frame = pageViewRect
        pageController!.didMoveToParentViewController(self)
    }
    
    func createPageContent(){
        var pageStrings = [String]()
        for i in 1...11
        {
            let contentString = "<html><head></head><body><br><h1>Chapter \(i)</h1> <p>This is the page \(i) of content displayed using UIPageViewController in iOS 8. </p></body></html>"
            pageStrings.append(contentString)
        }
        pageContent = pageStrings
    }
    
    func IndexOfController(contentViewController: ContentViewController) -> Int{
        var object = contentViewController.dataObject as! String
        if let index = find(self.pageContent, object){
            return index
        }
        else
        {
            return NSNotFound
        }
    }
    
    func ViewAtIndex(index: Int) -> ContentViewController? {
        if ((pageContent.count == 0) || (index >= pageContent.count)){
            return nil
        }
        var vc = self.storyboard?.instantiateViewControllerWithIdentifier("pageVC") as! ContentViewController
        vc.dataObject = pageContent[index]
        return vc
    }
    
}

extension PageDemoViewController: UIPageViewControllerDelegate{}

extension PageDemoViewController: UIPageViewControllerDataSource{
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?{
        var index = IndexOfController(viewController as! ContentViewController)
        if ((index == 0) || (index == NSNotFound)){
            return nil
        }
        index--
        return ViewAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?{
        var index = IndexOfController(viewController as! ContentViewController)
        if(index == NSNotFound){
            return nil
        }
        index++
        if (index >= pageContent.count){
            return nil
        }
        
        return ViewAtIndex(index)
    }
    
}
