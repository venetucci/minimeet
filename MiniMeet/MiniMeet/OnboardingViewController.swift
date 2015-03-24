//
//  OnboardingViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/15/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {


    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneImage.alpha = 0
        feedView.alpha = 0
        animateUp()
        
        scrollView.contentSize = feedView.frame.size
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButton(sender: AnyObject) {
        self.performSegueWithIdentifier("feedSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func animateUp() {
        var imagePosition = self.phoneImage.center.y
        var feedPosition = self.feedView.center.y
        
        UIView.animateWithDuration(0.8, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.phoneImage.center.y = imagePosition - 30
            self.feedView.center.y = feedPosition - 30
            self.phoneImage.alpha = 1
            self.feedView.alpha = 1
            
        }) { (bool) -> Void in
            
            UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.feedView.center.y = feedPosition - 500

            }, completion: { (bool) -> Void in
                //
            })
            
        }
    }

}
