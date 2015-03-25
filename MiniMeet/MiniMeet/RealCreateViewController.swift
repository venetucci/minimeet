//
//  RealCreateViewController.swift
//  MiniMeet
//
//  Created by dt on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class RealCreateViewController: UIViewController, UIScrollViewDelegate, MmDataEntryDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var imageLibrary: UIImageView!
    
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


        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectDateDidPress(sender: AnyObject) {
        performSegueWithIdentifier("selectDateSegue", sender: self)
        
    }
    
    
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
    
    
    // Method: Receive data :)
    
    func mMDidInputInfo(info:NSString){
        dateTextField.text = info
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
    
    // Animate the Library out of screen
    @IBAction func didPressThumbnail(sender: AnyObject) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.imageLibrary.center.y = 1000
        })
        
    }
    
    // Method: Incoming segue from the Select Date modal
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "selectDateSegue" {
            let vc2: SelectDateViewController = segue.destinationViewController as SelectDateViewController
            vc2.passDataDelegate = self
        }
    }
    
    
    @IBAction func didTapOutsideTextField(sender: AnyObject) {
        view.endEditing(true)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
