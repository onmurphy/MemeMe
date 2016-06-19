//
//  ViewController+UIPickerView.swift
//  MemeMe
//
//  Created by Olivia Murphy on 6/16/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import Foundation
import UIKit

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            setupTextField(topTextField, defaultText: topTextField.text!, color: UIColor.whiteColor())
            setupTextField(bottomTextField, defaultText: bottomTextField.text!, color: UIColor.whiteColor())
        case 1:
            setupTextField(topTextField, defaultText: topTextField.text!, color: UIColor.blackColor())
            setupTextField(bottomTextField, defaultText: bottomTextField.text!, color: UIColor.blackColor())
            
        case 2:
            setupTextField(topTextField, defaultText: topTextField.text!, color: UIColor.blueColor())
            setupTextField(bottomTextField, defaultText: bottomTextField.text!, color: UIColor.blueColor())
            
        case 3:
            setupTextField(topTextField, defaultText: topTextField.text!, color: UIColor.greenColor())
            setupTextField(bottomTextField, defaultText: bottomTextField.text!, color: UIColor.greenColor())
            
        case 4:
            setupTextField(topTextField, defaultText: topTextField.text!, color: UIColor.redColor())
            setupTextField(bottomTextField, defaultText: bottomTextField.text!, color: UIColor.redColor())
            
        default: ()
        }
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
    }

}