//
//  DetailsViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {
    
  

    @IBOutlet weak var attendeeOne: UIButton!
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
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitBackground: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var successView: UIView!
    
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
        descriptionTitle.alpha = 0
        submitButton.alpha = 0
        mapView.alpha = 0
        attendeeOne.alpha = 0
        submitView.alpha = 0
        submitBackground.alpha = 0
        successView.alpha = 0
        loadingImage.alpha = 0

        
        eventTitle.text = event?.title
        eventSubtitle.text = event?.subtitle
        descriptionText.text = event?.description
        
        self.view.backgroundColor = UIColor(red: 56/255, green: 77/255, blue: 103/255, alpha: 0.9)
        
        configureView()
        


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
                scrollView.alpha = 0
                
                // set endFrame properties
                endFrame = imageView.frame
                
                // shift the position by offset
                endFrame.origin.y = -offsetY
            }
    }


    @IBAction func submitButtonDidPress(sender: AnyObject) {
    
        var submitViewPostion = self.submitView.center.y
        var images = UIImage.animatedImageNamed("loading_", duration: 3.0)

        
        
        delay(0.4, { () -> () in
            UIView.animateWithDuration(0.3, animations: { () -> Void in

                self.submitBackground.alpha = 0.8
                

            }, completion: { (bool) -> Void in
                UIView.animateWithDuration(2.8, animations: { () -> Void in
                    self.loadingImage.alpha = 1
                    self.loadingImage.image = images
                    
                }, completion: { (bool) -> Void in
                    self.loadingImage.alpha = 0

                })
            })
        
        })
        
        delay(0.1, { () -> () in
            UIView.animateWithDuration(0.5, delay: 3.4, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.submitView.center.y = submitViewPostion + 30
                self.submitView.alpha = 1
                self.successView.alpha = 1
               
                }, completion: { (bool) -> Void in
                    UIView.animateWithDuration(0.2, delay: 2.8, options: nil, animations: { () -> Void in
                        //
                    }, completion: { (bool) -> Void in
                        //
                    })
            })
        })
    }

    
    
    


    // animate event details description and map on page load

    @IBAction func browseButtonDidPress(sender: AnyObject) {
        var offsetY = imageView.frame
    
        
            dismissViewControllerAnimated(true, completion: nil)
            imageView.alpha = 0
            scrollView.alpha = 0
            
            // set endFrame properties
             endFrame = imageView.frame
        
            // shift the position by offset
            // endFrame.origin.y = -offsetY
        
        
    
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
            self.descriptionText.center.y = descriptionPosition + 30
            self.descriptionText.alpha = 1
            self.descriptionTitle.center.y = descriptionTitlePosition + 30
            self.descriptionTitle.alpha = 1
            self.attendeeOne.alpha = 1
           // self.eventTitle.center.y = titlePosition + 10
           // self.eventSubtitle.center.y = subtitlePosition + 10
            
            
        }) { (bool) -> Void in
            //
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
    
    
    
    
    
    
    
    
   
}
