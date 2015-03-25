//
//  OnboardingViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/15/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {


    @IBOutlet weak var browseButton: UIButton!
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
        mainScrollView.delegate = self
        mainScrollView.contentSize = CGSize(width: 1280, height: 568)
        
        scrollViewDidEndDecelerating(mainScrollView)
        
        browseButton.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("seguing")
    }
    
    

    
    func didChangePage() {
        var page = Int(mainScrollView.contentOffset.x / 320)
        pageControl.currentPage = page
        
        var imagePosition = self.phoneImage.center.y
        var feedPosition = self.feedView.center.y
        var createPosition = self.createScreen.center.y
        
        
        if (page == 0) {
            UIView.animateWithDuration(0.8, delay: 0.8, usingSpringWithDamping: 0.5, initialSpringVelocity: 40, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.phoneImage.center.y = imagePosition - 30
                self.feedView.center.y = feedPosition - 30
                self.phoneImage.alpha = 1
                self.feedView.alpha = 1
                
                }) { (bool) -> Void in
                    //
            }
        } else if (page == 1) {
            
            UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.scrollView.contentOffset.y = feedPosition + 100
                
                
                }, completion: { (bool) -> Void in
                    //
            })
        } else if (page == 2) {
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
               
                self.createScreen.center.y = createPosition - 258
                
                }, completion: { (bool) -> Void in
                self.scrollView.contentOffset.y = feedPosition - 500
            })
            
        } else if (page == 3) {
            browseButton.alpha = 1
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        didChangePage()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if decelerate == false {
            didChangePage()
        }
    }
    
    
    
    @IBAction func browseButtonDidPress(sender: AnyObject) {
        println("test")
    }
    
    


}
