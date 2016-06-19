//
//  ViewController.swift
//  MemeMe
//
//  Created by Olivia Murphy on 5/27/16.
//  Copyright © 2016 Murphy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    struct Meme {
        let topText: String
        let bottomText: String
        let image: UIImage
        let memedImage: UIImage
    }
    
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
    @IBOutlet weak var fontToolbar: UINavigationBar!
    
    // MARK: IBAction functions 
    
    @IBAction func shareClicked(sender: AnyObject) {
        print ("CLICKED")
        
        let meme = generateMemedImage()
        
        let activityViewController = UIActivityViewController(
            activityItems: [meme],
            applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        setupTextField(topTextField, defaultText: "", color: UIColor.whiteColor())
        setupTextField(bottomTextField, defaultText: "", color: UIColor.whiteColor())
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imagePickerView.image = nil
    }
    
    @IBAction func changeFontClicked(sender: AnyObject) {
        fontPicker.hidden = false
        fontToolbar.hidden = false
    }
    
    @IBAction func doneChoosingFont(sender: AnyObject) {
        fontPicker.resignFirstResponder()
        fontPicker.hidden = true
        fontToolbar.hidden = true
    }
    
    @IBAction func pickImageFromAlbum(sender: AnyObject) {
        presentImagePicker(.SavedPhotosAlbum)
    }
    
    @IBAction func pickAnImageFromCamera (sender: AnyObject) {
        presentImagePicker(.Camera)
    }
    
    // MARK: Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomTextField.delegate = self
        topTextField.delegate = self
        setupTextField(topTextField, defaultText: "TOP", color: UIColor.whiteColor())
        setupTextField(bottomTextField, defaultText: "BOTTOM", color: UIColor.whiteColor())

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
        fontToolbar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: imagePicker functions
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = imagePicked
            imagePickerView.contentMode = .ScaleAspectFit
            shareButton.enabled = true
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
         dismissViewControllerAnimated(true, completion: nil)
    }
    
    func presentImagePicker(chosenSource: UIImagePickerControllerSourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = chosenSource
        presentViewController(pickerController, animated: true, completion: nil)
    }
    
    
    // MARK: functions to generate and save image 
    
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

