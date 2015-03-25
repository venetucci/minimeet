//
//  OnboardingViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/15/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var createScreen: UIImageView!
    @IBOutlet weak var welcomeFirstImage: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        phoneImage.alpha = 0
        feedView.alpha = 0
        
        
        scrollView.contentSize = feedView.frame.size
        createScreen.alpha = 0
        mainScrollView.delegate = self
        mainScrollView.contentSize = CGSize(width: 1280, height: 568)
        

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
    
//    func animateUp() {
//        var imagePosition = self.phoneImage.center.y
//        var feedPosition = self.feedView.center.y
//        
//        UIView.animateWithDuration(0.8, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//            self.phoneImage.center.y = imagePosition - 30
//            self.feedView.center.y = feedPosition - 30
//            self.phoneImage.alpha = 1
//            self.feedView.alpha = 1
//            
//        }) { (bool) -> Void in
//            
//            UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                self.feedView.center.y = feedPosition - 500
//
//            }, completion: { (bool) -> Void in
//                //
//            })
//            
//        }
//    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var page = Int(mainScrollView.contentOffset.x / 320)
        pageControl.currentPage = page
        
        var imagePosition = self.phoneImage.center.y
        var feedPosition = self.feedView.center.y
        
        
        if (page == 1) {
            UIView.animateWithDuration(0.8, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.phoneImage.center.y = imagePosition - 30
                self.feedView.center.y = feedPosition - 30
                self.phoneImage.alpha = 1
                self.feedView.alpha = 1
                
                }) { (bool) -> Void in
                    //
            }
        } else if (page == 2) {
            
            UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.feedView.center.y = feedPosition - 500
                
                }, completion: { (bool) -> Void in
                    //
            })
        } else if (page == 3) {
            createScreen.alpha = 1
        }
    }


}
