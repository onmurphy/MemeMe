//
//  ViewController.swift
//  MemeMe
//
//  Created by Olivia Murphy on 5/27/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    struct Meme {
        let topText: String
        let bottomText: String
        let image: UIImage
        let memedImage: UIImage
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    let pickerData = ["White", "Black", "Blue", "Green", "Red"]
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var changeFontButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var fontPicker: UIPickerView!
    
    @IBAction func shareClicked(sender: AnyObject) {
        print ("CLICKED")
        
        let meme = save()
        
        let activityViewController = UIActivityViewController(
            activityItems: [meme.memedImage as UIImage],
            applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
    }
    
    @IBAction func changeFontClicked(sender: AnyObject) {
        fontPicker.hidden = false
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomTextField.delegate = self
        self.topTextField.delegate = self
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center
        fontPicker.dataSource = self
        fontPicker.delegate = self
        fontPicker.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        if imagePickerView.image == nil {
            shareButton.enabled = false
        } else {
            shareButton.enabled = true
        }
        fontPicker.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0)
        {
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.whiteColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -3.0
            ]
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
        else if(row == 1)
        {
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.blackColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -3.0
            ]
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
        else if(row == 2)
        {
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.blueColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -3.0
            ]
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
        else if(row == 3)
        {
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.greenColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -3.0
            ]
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
        
        else if(row == 4)
        {
            let memeTextAttributes = [
                NSStrokeColorAttributeName : UIColor.blackColor(),
                NSForegroundColorAttributeName : UIColor.redColor(),
                NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                NSStrokeWidthAttributeName : -3.0
            ]
            topTextField.defaultTextAttributes = memeTextAttributes
            bottomTextField.defaultTextAttributes = memeTextAttributes
        }
        
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.textAlignment = NSTextAlignment.Center

        fontPicker.resignFirstResponder()
        fontPicker.hidden = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = imagePicked
            imagePickerView.contentMode = .ScaleAspectFit
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.keyBoardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyBoardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func save() -> Meme {
        //Create the meme
        let meme = Meme( topText: topTextField.text!, bottomText: bottomTextField.text!, image:
            imagePickerView.image!, memedImage: generateMemedImage())
        
        return meme
    }
    
    func generateMemedImage() -> UIImage
    {
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        
        return memedImage
    }
}

