//
//  CollectionViewController.swift
//  MemeMe
//
//  Created by Olivia Murphy on 7/15/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        let dimension = (self.view.frame.size.width - (2 * 3.0)) / 3.0
        flowLayout.minimumInteritemSpacing = 3.0
        flowLayout.minimumLineSpacing = 3.0
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView!.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.meme = appDelegate.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCell", forIndexPath: indexPath) as! CustomCollectionViewCell
        let meme = appDelegate.memes[indexPath.item]
        cell.imageView?.image = meme.memedImage
        return cell
    }
}