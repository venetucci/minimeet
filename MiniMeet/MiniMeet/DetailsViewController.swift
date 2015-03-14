//
//  DetailsViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = imageView.frame.size
        scrollView.delegate = self

        imageView.image = event?.image
        imageView.hidden = true
        
        eventTitle.text = event?.title
        eventSubtitle.text = event?.subtitle
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        imageView.hidden = false
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
            
            if scrollView.contentOffset.y < -60 {
                dismissViewControllerAnimated(true, completion: nil)
                imageView.alpha = 0
                cancelButton.hidden = true
                
            }
    }


    @IBAction func submitButtonDidPress(sender: AnyObject) {
        
        var alertView = UIAlertView(title: "You're all signed up!", message: "Get ready for some good company.", delegate: self, cancelButtonTitle: "Browse more meetups")
        alertView.show()
        
        delay(2, { () -> () in
//           alertView.dismissWithClickedButtonIndex(0, animated: true)

            self.performSegueWithIdentifier("attendEventSegue", sender: self)
            
        })

    }
}
