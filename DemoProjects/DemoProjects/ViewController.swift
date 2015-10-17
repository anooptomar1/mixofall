//
//  ViewController.swift
//  DemoProjects
//
//  Created by Anoop tomar on 10/9/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
    //, UICollectionViewDelegateFlowLayout
{
    var menuItems: [MenuItem] = []

    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.delegate = self
        collView.dataSource = self
        addMenuItems()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0, green: 0.22, blue: 0.514, alpha: 0.4)
    }
    
    func addMenuItems(){
        menuItems.append(MenuItem(title: "Text Effect 1", id: 1, titleImage: UIImage(named: "sample")!, sbName: "textEffect1"))
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! VCCollectionViewCell
        let item = menuItems[indexPath.row]
        cell.titleText.text = item.title
        cell.imageView.image = item.titleImage
        return cell
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        presentViewController(UINavigationController(rootViewController: UIStoryboard(name: menuItems[indexPath.row].sbName, bundle: nil).instantiateViewControllerWithIdentifier("mainVC") as UIViewController), animated: true, completion: nil)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSizeMake(self.collView.bounds.width - 30, self.collView.bounds.height - 100)
//    }
}

