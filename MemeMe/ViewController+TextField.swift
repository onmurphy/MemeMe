//
//  ViewController+TextField.swift
//  MemeMe
//
//  Created by Olivia Murphy on 6/16/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func setupTextField(textField: UITextField, defaultText: String, color: UIColor) {
        textField.text = defaultText
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : color,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0
        ]
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
    }
}