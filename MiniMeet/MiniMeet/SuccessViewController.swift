//
//  SuccessViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/23/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var loadingSequence: UIImageView!
    @IBOutlet weak var successBGView: UIView!
    @IBOutlet weak var confirmCardView: UIView!
    
    let loadingImages = UIImage.animatedImageNamed("loading_", duration: 3.0)
    var cardOffsetY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmCardView.alpha = 0
        successBGView.alpha = 0
        loadingSequence.alpha = 0
        
        // move card off screen by view height
        cardOffsetY = self.view.frame.height
        confirmCardView.center.y = confirmCardView.center.y - cardOffsetY
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // animate background alpha
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.successBGView.alpha = 0.8
            }, completion: { (bool) -> Void in
        })
        
        // show loading sequence and animate the card in
        animateCardDown(3.5)
    }
    
    @IBAction func browseMoreDidPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
//        UIStoryboardSegue.
    }

    // loading animation
    func loadingAnimation(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.loadingSequence.alpha = 1
            self.loadingSequence.image = self.loadingImages
            
            }, completion: { (bool) -> Void in
            self.loadingSequence.alpha = 0
            self.successBGView.alpha = 0.7
        })
    }
    
    func animateCardDown(delayTime: NSTimeInterval) {
        // animate for as long as the animation is delayed
        loadingAnimation(delayTime)
        
        UIView.animateWithDuration(0.5, delay: delayTime, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.confirmCardView.center.y = self.confirmCardView.center.y + self.cardOffsetY
            self.confirmCardView.alpha = 1
            //                self.successView.alpha = 1
            
            }, completion: { (bool) -> Void in
                // code
        })
    }
}