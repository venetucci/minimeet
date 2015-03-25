//
//  DetailsViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
  
    @IBOutlet var detailsViewContainer: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet var profileButtonArray: [UIButton]!
    
    var event: Event?
    var endFrame: CGRect! // the final position upon end drag
    
    // custom transitions
    var successVC: SuccessViewController!
    var successTransition: FadeTransition!

    override func viewDidLoad() {
        super.viewDidLoad()

        // set the scroll view height
        scrollView.contentSize = contentView.frame.size
        scrollView.delegate = self

        // set default states of assets
        imageView.image = event?.image
        imageView.hidden = true
        descriptionText.alpha = 0
        descriptionTitle.alpha = 0
        submitButton.alpha = 0
        mapView.alpha = 0

        // setting the type
        var titleString = event?.title
        var mutableString = NSMutableAttributedString(string: titleString!, attributes: [NSKernAttributeName: 8] )
        eventTitle.numberOfLines = 2
        eventTitle.lineBreakMode =  NSLineBreakMode.ByWordWrapping
        eventTitle.attributedText = mutableString
        descriptionTitle.attributedText = NSMutableAttributedString(string: "ABOUT", attributes: [NSKernAttributeName: 6] )
        
        eventSubtitle.text = event?.subtitle
        eventTime.text = event?.timeString
        eventLocation.text = event?.location
        descriptionText.text = event?.description
        
        // custom view added to storyboard
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        successVC = storyboard.instantiateViewControllerWithIdentifier("successSBID") as SuccessViewController
        
        // set the background color and alpha of detailsViewController
        self.view.backgroundColor = UIColor(red: 56/255, green: 77/255, blue: 103/255, alpha: 0.9)
        
        // hide all the buttons when view loads
        hideProfileButtonArray()
        
        // set the custom font styles
        configureView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView.hidden = false
        
        // show only buttons that map to the number of attendees
        showProfileButtonArray()
        
        // slide the descriptions down
        animateDetailsDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func hideProfileButtonArray() {
        for var index = 0; index < profileButtonArray.count; ++index {
            profileButtonArray[index].alpha = 0
        }
    }
    
    func showProfileButtonArray() {
        UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: { () -> Void in
            for var index = 0; index < self.event?.attendeeArray.count; ++index {
                var buttonProfile = self.profileButtonArray[index]
                var attendeeImage = UIImage(named: self.event?.attendeeArray[index] as String!)
                buttonProfile.setImage(attendeeImage, forState: .Normal)
                buttonProfile.alpha = 1
            }
        }) { (Bool) -> Void in
            // code
        }
    }
    
    // shot the profile picture by swapping the button assets
    func animateInProfileButtons() {
        for var index = 0; index < event?.attendeeArray.count; ++index {
            var buttonProfile = self.profileButtonArray[index]
            // swap the image
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        var newImagePoint = imageView.frame.origin
        var offsetFade = 1 - (scrollView.contentOffset.y / -60)
        submitButton.alpha = offsetFade
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            
            var offsetY = scrollView.contentOffset.y
            
            if scrollView.contentOffset.y < -60 {
                dismissViewControllerAnimated(true, completion: nil)
                imageView.alpha = 0
                
                // instead of entire scrollView break up the components and alpha out individually
                scrollView.alpha = 0.5
                
                // set endFrame properties
                endFrame = imageView.frame
                
                // shift the position by offset
                endFrame.origin.y = -offsetY
            }
    }

    @IBAction func submitButtonDidPress(sender: AnyObject) {
        self.performSegueWithIdentifier("successSegue", sender: self)
    }

    // animate event details description and map on page load
    @IBAction func browseButtonDidPress(sender: AnyObject) {
        var offsetY = imageView.frame
        
            dismissViewControllerAnimated(true, completion: nil)
            imageView.alpha = 0
            scrollView.alpha = 0
            
            // set endFrame properties
             endFrame = imageView.frame
    }

    func animateDetailsDown () {
        var descriptionPosition = self.descriptionText.center.y
        var descriptionTitlePosition = self.descriptionTitle.center.y
        var submitPosition = self.submitButton.center.y
        var mapPosition = self.mapView.center.y
        let duration: NSTimeInterval = 0.8
        
        var titlePosition = self.eventTitle.center.y
        var subtitlePosition = self.eventSubtitle.center.y
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.descriptionText.center.y = descriptionPosition + 20
            self.descriptionText.alpha = 1
            self.descriptionTitle.center.y = descriptionTitlePosition + 20
            self.descriptionTitle.alpha = 1
        }) { (bool) -> Void in
            // code
        }
        
        UIView.animateWithDuration(duration, delay: 0.15, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.submitButton.center.y = submitPosition + 30
            self.submitButton.alpha = 1
            }) { (bool) -> Void in
                //
        }
        
        UIView.animateWithDuration(duration, delay: 0.35, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.mapView.center.y = mapPosition + 30
            self.mapView.alpha = 1
        }) { (bool) -> Void in
            //
        }
    }
    
    func configureView() {
        var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        paragraphStyle.lineSpacing = 4.0
        var attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        var attributedString = NSAttributedString(string: descriptionText!.text!, attributes: attributes)
        descriptionText.attributedText = attributedString
    }

    // add a subbview to the specified container
    func displayContentController(container: UIView, content: UIViewController) {
        addChildViewController(content)
        detailsViewContainer.addSubview(content.view)
        content.didMoveToParentViewController(self)
    }
    
    // remove a subview from the specified container
    func hideContentController(container: UIView, content: UIViewController) {
        content.willMoveToParentViewController(nil)
        content.view.removeFromSuperview()
        content.removeFromParentViewController()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationViewController = segue.destinationViewController as UIViewController
        
        // instantiate the transition
        successTransition = FadeTransition()
        successTransition.duration = 0.0
        
        destinationViewController.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationViewController.transitioningDelegate = successTransition
    }
}
