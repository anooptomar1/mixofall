//
//  CollectionVDemoViewController.swift
//  CodeSamples
//
//  Created by Anoop tomar on 5/20/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import UIKit

class CollectionVDemoViewController: UIViewController {

    @IBOutlet weak var collView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collView.dataSource = self
        collView.delegate = self
    }
}

extension CollectionVDemoViewController: UICollectionViewDataSource{

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ColViewCell
        cell.labelText.text = "Row number: \(indexPath.row)"
        return cell
    }
}

extension CollectionVDemoViewController: UICollectionViewDelegate{}