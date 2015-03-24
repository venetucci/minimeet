//
//  SecondaryFeedViewController.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class SecondaryFeedViewController: UIViewController {

    @IBOutlet weak var loadingBackground: UIView!
    @IBOutlet weak var gotThumbnail: UIImageView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var gotImage: UIImageView!
    @IBOutlet weak var loadingText: UILabel!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateLoad()
        gotImage.alpha = 0
        
        scrollView.contentSize = feedView.frame.size
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func animateLoad () {
        
        UIView.animateWithDuration(5.0, delay: 0.1, options: UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            var images = UIImage.animatedImageNamed("load_", duration: 5.0)
            self.loadingImage.image = images
        }) { (bool) -> Void in
            UIView.animateWithDuration(0.1, delay: 4.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.gotImage.alpha = 1
                self.loadingImage.alpha = 0
                self.loadingText.alpha = 0
                self.loadingBackground.alpha = 0
                self.gotThumbnail.alpha = 0
            }, completion: { (bool) -> Void in
                
                UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    var gotPosition = self.gotImage.center.y
                    var feedPosition = self.feedImage.center.y
                    self.gotImage.center.y = gotPosition + 135
                    self.feedImage.center.y = feedPosition + 135
                }, completion: { (bool) -> Void in
                    //
                })
                
                
            })
        }
        
        
        
        
        
        
        
        
    }

}
