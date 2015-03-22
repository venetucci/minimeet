//
//  DetailsViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mapView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var event: Event?

    // the final position upon end drag
    var endFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = contentView.frame.size
        scrollView.delegate = self

        imageView.image = event?.image
        imageView.hidden = true
        
        descriptionText.alpha = 0
        mapView.alpha = 0
        
        eventTitle.text = event?.title
        eventSubtitle.text = event?.subtitle

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView.hidden = false
        animateDetailsDown()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPressCancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        var newImagePoint = imageView.frame.origin
        var offsetFade = 1 - (scrollView.contentOffset.y / -60)
        
        cancelButton.alpha = offsetFade
        submitButton.alpha = offsetFade
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView!,
        willDecelerate decelerate: Bool) {
            
            var offsetY = scrollView.contentOffset.y
            
            if scrollView.contentOffset.y < -60 {
                dismissViewControllerAnimated(true, completion: nil)
                imageView.alpha = 0
                scrollView.alpha = 0
                cancelButton.hidden = true
                
                // set endFrame properties
                endFrame = imageView.frame
                
                // shift the position by offset
                endFrame.origin.y = -offsetY
            }
    }


    @IBAction func submitButtonDidPress(sender: AnyObject) {
        
        var alertView = UIAlertView(title: "You're all signed up!", message: "Get ready for some good company.", delegate: self, cancelButtonTitle: "Browse more meetups")
        alertView.show()
        
        delay(2, { () -> () in
        // alertView.dismissWithClickedButtonIndex(0, animated: true)
       self.performSegueWithIdentifier("attendEventSegue", sender: self)
        })
    }


    // animate event details description and map on page load

    func animateDetailsDown () {
        var descriptionPosition = self.descriptionText.center.y
        var mapPosition = self.mapView.center.y
        let duration: NSTimeInterval = 0.8
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.descriptionText.center.y = descriptionPosition + 30
            self.descriptionText.alpha = 1
            
        }) { (bool) -> Void in
            //
        }
        
        UIView.animateWithDuration(duration, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: nil, animations: { () -> Void in
            self.mapView.center.y = mapPosition + 30
            self.mapView.alpha = 1
        }) { (bool) -> Void in
            //
        }
    }
   
}
