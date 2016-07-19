//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Olivia Murphy on 7/15/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView!.image = meme.memedImage
    }
    
    @IBAction func editMeme() {
        let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("NewMemeController") as! ViewController
        viewController.bottomTextField.text = meme.bottomText
        viewController.topTextField.text = meme.topText
        viewController.imagePickerView.image = meme.image
        self.navigationController!.pushViewController(viewController, animated: true)
    }
}