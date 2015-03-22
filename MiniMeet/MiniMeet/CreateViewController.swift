//
//  CreateViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit
import Foundation

class CreateViewController: UIViewController, UIActionSheetDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    var borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Event"
        
        scrollView.contentSize = contentView.frame.size
        
        
        titleTextField!.layer.borderWidth = 1
        titleTextField!.layer.borderColor = borderColor.CGColor
        titleTextField.layer.cornerRadius = 5
        dateTextField!.layer.borderWidth = 1
        dateTextField!.layer.borderColor = borderColor.CGColor
        dateTextField.layer.cornerRadius = 5
        locationTextField!.layer.borderWidth = 1
        locationTextField!.layer.borderColor = borderColor.CGColor
        locationTextField.layer.cornerRadius = 5
        descriptionTextField!.layer.borderWidth = 1
        descriptionTextField!.layer.borderColor = borderColor.CGColor
        descriptionTextField.layer.cornerRadius = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

    @IBAction func cancelDidPress(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    // Calculate hex values for color: 
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            

            }, completion: nil)
        

    }
    
    
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as NSNumber
        var animationCurve = curveValue.integerValue
    }
    
    @IBAction func submitButtonDidPress(sender: AnyObject) {
        
        if countElements(titleTextField.text) == 0 {
            UIAlertView(title: "Meetup Name Required", message: "Please create a name for your meetup!", delegate: self, cancelButtonTitle: "OK").show()
        } else if countElements(dateTextField.text) == 0 {
            UIAlertView(title: "Date Required", message: "Please select a day for your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else if countElements(locationTextField.text) == 0 {
            UIAlertView(title: "Location Required", message: "Please select a location for your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else if countElements(descriptionTextField.text) == 0 {
            UIAlertView(title: "Description Required", message: "Please describe your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else {
            var alertView = UIAlertView(title: "Thanks for creating an event!", message: nil, delegate: nil, cancelButtonTitle: nil)
            alertView.show()
        
        delay(2, { () -> () in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
            
                if countElements(self.titleTextField.text) > 1 && countElements(self.descriptionTextField.text) > 1 {
                    self.performSegueWithIdentifier("submitEventSegue", sender: self)
                } else {
                    UIAlertView(title: "Sign In Failed", message: "Incorrect email or password", delegate: self, cancelButtonTitle: "OK").show()
                }
            })
        }
    }

    
    @IBAction func addImageDidPress(sender: AnyObject) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) {
            action -> Void in
        }

        actionSheetController.addAction(cancelAction)

        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) {
            action -> Void in
        }

        actionSheetController.addAction(takePictureAction)

        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) {
            action -> Void in
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        actionSheetController.popoverPresentationController?.sourceView = sender as UIView;
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
    }
       
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

