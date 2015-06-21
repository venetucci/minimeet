//
//  SignInViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/15/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var loadingBackground: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var loginContainer: UIView!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        loadingImage.alpha = 0
        loadingBackground.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        if let userInfo = notification.userInfo,
            keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
            curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber {

                let animationDuration = durationValue.doubleValue
                let kbSize = keyboardFrame.CGRectValue().size
                let animationCurve = curveValue.integerValue

                UIView.animateWithDuration(animationDuration,
                    delay: 0.0,
                    options: UIViewAnimationOptions(UInt(animationCurve << 16)),
                    animations: {
                        self.loginContainer.center.y = kbSize.height - self.loginContainer.center.y/8
                        self.buttonContainer.center.y = kbSize.height + self.buttonContainer.center.y/6
                        self.logo.center.y = self.logo.center.y - 15
                    },
                    completion: nil)
        } else {
            print("Keyboard notification arrived but not as expected :(")
        }
    }

    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            self.loginContainer.center.y = kbSize.height + self.loginContainer.center.y/10
            self.buttonContainer.center.y = kbSize.height + self.buttonContainer.center.y/1
            self.logo.center.y = kbSize.height + self.logo.center.y*(-1.5)
            }, completion: nil)
    }

    @IBAction func signIn(sender: AnyObject) {
        
        PFUser.logInWithUsernameInBackground(emailTextField.text, password: passwordTextField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                println("logged in!")
                            var images = UIImage.animatedImageNamed("loading_", duration: 3.0)
                            self.loadingImage.image = images
                            self.loadingImage.alpha = 1
                            self.loadingBackground.alpha = 0.7
            
                            delay(2, { () -> () in
                                self.performSegueWithIdentifier("welcomeSegue", sender: self)
                            })
            } else {
                if let error = error {
                    var alertView = UIAlertView(title: "oops", message: error.description, delegate: nil, cancelButtonTitle: "OK")
                    alertView.show()
                }
                
            }

        }
        
        
//  non parse login
//        if countElements(emailTextField.text) == 0 {
//            UIAlertView(title: "Email Required", message: "Please enter your email address", delegate: self, cancelButtonTitle: "OK").show()
//        } else if countElements(passwordTextField.text) == 0 {
//            UIAlertView(title: "Password Required", message: "Please enter your password", delegate: self, cancelButtonTitle: "OK").show()
//        } else {
//
//            var images = UIImage.animatedImageNamed("loading_", duration: 3.0)
//            loadingImage.image = images
//            loadingImage.alpha = 1
//            loadingBackground.alpha = 0.7
//            
//            delay(2, { () -> () in
//                self.performSegueWithIdentifier("welcomeSegue", sender: self)
//            })
//            
//        }

    }
   
    @IBAction func onTap(sender: UITapGestureRecognizer) {
         view.endEditing(true)
    }
}
