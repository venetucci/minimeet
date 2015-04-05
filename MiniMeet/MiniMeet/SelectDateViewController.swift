//
//  SelectDateViewController.swift
//  MiniMeet
//
//  Created by dt on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

// Add protocol and delegate
protocol MmDataEntryDelegate {
    func mMDidInputInfo(info:NSString)
}

class SelectDateViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    // Date Picker
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // Initialize the date & time label
    @IBOutlet weak var dateTimeLabel: UILabel! = UILabel()
    
    // Declare Pass Data Delegate
    var passDataDelegate: MmDataEntryDelegate? = nil
    
    // Presenting Custom Transition
    var isPresenting: Bool = true
    
    // Initializer: required to customize how this Vc is presented modally
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    // Custom Transition - Start Methods
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {

        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 0.95
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
            
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    // Custom Transition - End Methods

    
    // Date Picker Method: Set Date
    
    @IBAction func didPickDateTime(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy | h:mm a"
        var dateString = dateFormatter.stringFromDate(datePicker.date)
        self.dateTimeLabel.text = dateString
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        
    }
    
    // Method: Pass the data, dude.
    @IBAction func saveDateDidPress(sender: AnyObject) {
        
        if (passDataDelegate != nil) {
            let information: NSString = dateTimeLabel.text!
            passDataDelegate!.mMDidInputInfo(information)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // JUNK...

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
