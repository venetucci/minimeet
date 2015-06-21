//
//  RealCreateViewController.swift
//  MiniMeet
//
//  Created by dt on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit
import Parse

protocol CreateViewControllerDelegate: NSObjectProtocol {
    func createViewController(viewcontroller: RealCreateViewController, didCreateEvent event: PFObject)
}

class RealCreateViewController: UIViewController, UIScrollViewDelegate, MmDataEntryDelegate, VenueEntryDelegate {

    weak var delegate: CreateViewControllerDelegate?
    
    // Scroll View
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // Images
    @IBOutlet weak var newImage: UIImageView!
    @IBOutlet weak var libraryImage: UIImageView!
    
    // Buttons
    @IBOutlet weak var selectFromLibraryButton: UIButton!
    
    // Containers
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var detailsSaveContainer: UIView!
    
    // Labels
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Text Fileds and Views
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var borderColor = UIColor(red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = contentView.frame.size
        scrollView.delegate = self
        
        eventTitleTextField!.layer.borderWidth = 1
        eventTitleTextField!.layer.borderColor = borderColor.CGColor
        eventTitleTextField.layer.cornerRadius = 5
        dateTextField!.layer.borderWidth = 1
        dateTextField!.layer.borderColor = borderColor.CGColor
        dateTextField.layer.cornerRadius = 5
        locationTextField!.layer.borderWidth = 1
        locationTextField!.layer.borderColor = borderColor.CGColor
        locationTextField.layer.cornerRadius = 5
        descriptionTextView!.layer.borderWidth = 1
        descriptionTextView!.layer.borderColor = borderColor.CGColor
        descriptionTextView.layer.cornerRadius = 5
        
        newImage.alpha = 0
        selectFromLibraryButton.alpha = 0
        
        // Register for keyboard events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        println(view.center.y)
    }
    
    
    // Segue to Date Selection
    @IBAction func selectDateDidPress(sender: AnyObject) {
        performSegueWithIdentifier("selectDateSegue", sender: self)
    }
    
    
    // Segue to Location Selection
    @IBAction func selectLocationDidPress(sender: AnyObject) {
        performSegueWithIdentifier("selectLocationSegue", sender: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButtonDidPress(sender: AnyObject) {
        performSegueWithIdentifier("secondaryFeedSegue", sender: self)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
        
        println("content offeset: \(scrollView.contentOffset.y)")
    }
    
    // Method: Receive Date data :)
    func mMDidInputInfo(info:NSString){
        dateTextField.text = info as String
    }
    
    // Method: Receieve Location data :)
    func UserDidInputInfoVenue(info:NSString){
        locationTextField.text = info as String
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
    

    
     // KEYBOARD METHODS
    
//        func textFieldShouldReturn(textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            return true
//        }
    
    // Show Keyboard
    func keyboardWillShow(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties to match with the animation of the keyboard
            

//            self.infoContainer.center.y = kbSize.height - self.infoContainer.center.y / 3
//            self.detailsSaveContainer.center.y = kbSize.height + self.detailsSaveContainer.center.y / 3
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0)

            }, completion: nil)
    }
    
    // Hide Keyboard
    func keyboardWillHide(notification: NSNotification!) {
        var userInfo = notification.userInfo!
        
        // Get the keyboard height and width from the notification
        // Size varies depending on OS, language, orientation
        var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
        var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var animationDuration = durationValue.doubleValue
        var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
        var animationCurve = curveValue.integerValue
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: UIViewAnimationOptions(UInt(animationCurve << 16)), animations: {
            
            // Set view properties to match with the animation of the keyboard
            
            
            self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)

        }, completion: nil)
    }
    
    // Create Button
    @IBAction func didPressCreateButton(sender: AnyObject) {
        
        // write to parse
        var newEvent = PFObject(className:"Events")
        newEvent["event_name"] = eventTitleTextField.text
        newEvent["event_desc"] = descriptionTextView.text
        newEvent["event_location"] = locationTextField.text
        
        
        // get date dynamically from the picker and pass to parse
        var dateString = dateTextField.text
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        
        newEvent["event_date"] = dateFormatter.dateFromString(dateString)
        
        // create an PFFile
        var image = UIImage(named: "xcode")
        let imageData = UIImagePNGRepresentation(image)
        let imageFile = PFFile(name:"new_event.png", data:imageData)
        
        newEvent["event_image"] = imageFile
        newEvent["event_attd"] = ["michelle"]
        
        newEvent.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
                println("succesfully pushed to parse: \(newEvent.objectId)")
            } else {
                // There was a problem, check error.description
            }
        }
        
        if count(eventTitleTextField.text) == 0 {
            UIAlertView(title: "Meetup Name Required", message: "Please create a name for your meetup!", delegate: self, cancelButtonTitle: "OK").show()
        } else if count(dateTextField.text) == 0 {
            UIAlertView(title: "Date Required", message: "Please select a day for your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else if count(locationTextField.text) == 0 {
            UIAlertView(title: "Location Required", message: "Please select a location for your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else if count(descriptionTextView.text) == 0 {
            UIAlertView(title: "Description Required", message: "Please describe your meetup", delegate: self, cancelButtonTitle: "OK").show()
        } else {
            var alertView = UIAlertView(title: "Thanks for creating an event!", message: nil, delegate: nil, cancelButtonTitle: nil)
            alertView.show()
            
            // tell feed view controller we added event with ID: X
            // Feed view controller will fetch event with ID: X
            // Feed view controller will dismiss us
            // Feed view controller will add new cell to index 0 showing event with ID: X
            
            //self.performSegueWithIdentifier("createFinishSegue", sender: self)
            delegate?.createViewController(self, didCreateEvent: newEvent)
            
            delay(0.2, { () -> () in
                alertView.dismissWithClickedButtonIndex(0, animated: true)
                
                if count(self.eventTitleTextField.text) > 1 && count(self.descriptionTextView.text) > 1 {
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    
                } else {
                    UIAlertView(title: "Please complete all fields.", message: "You did not enter enough characters.", delegate: self, cancelButtonTitle: "OK").show()
                }
            })
        }
    }
    
    // Method: Return Segues from Date and Location
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectDateSegue" {
            let vc2: SelectDateViewController = segue.destinationViewController as! SelectDateViewController
            vc2.passDataDelegate = self
        }
        
        if segue.identifier == "selectLocationSegue" {
            let vcLocation: SelectLocationViewController = segue.destinationViewController as! SelectLocationViewController
            vcLocation.passVenueDataDelegate = self
        }
        
    }
    
    @IBAction func didTapOutsideTextField(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func addButtonDidPress(sender: AnyObject) {
        var libraryPosition = self.libraryImage.center.y
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.libraryImage.center.y = libraryPosition - 568
            self.selectFromLibraryButton.alpha = 1
            
            }, completion: { (bool) -> Void in
                //
        })
    }
    
    @IBAction func didPressBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressImageButton(sender: AnyObject) {
        
        var libraryPosition = self.libraryImage.center.y
        
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.libraryImage.center.y = libraryPosition + 568
        }) { (bool) -> Void in
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.newImage.alpha = 1
            })
        }
    }
}
