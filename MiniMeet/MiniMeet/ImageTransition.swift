//
//  ImageTransition.swift
//  facebookish-2
//
//  Created by Michelle Venetucci Harvey on 2/28/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ImageTransition: BaseTransition {
    
    var snapshot: UIView?
    var snapshotStartFrame = CGRectZero
    var snapshotEndFrame = CGRectZero
    var dotArray: [UIImageView]!
    var dotArrayOriginFrames: [CGRect]!
    var attendeeArray: [String]!
    var convertedStartFrame = CGRectZero
    var convertedEndFrame = CGRectZero
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        var tabViewController = fromViewController as! TabViewController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        var feedViewController = navigationController.topViewController as! FeedViewController
        var detailsViewController = toViewController as! DetailsViewController
        
        convertedStartFrame = containerView.convertRect(snapshotStartFrame, fromView: feedViewController.eventTableView)
        convertedEndFrame = containerView.convertRect(detailsViewController.containerView.frame, fromView: detailsViewController.view)
        
        snapshot?.frame = convertedStartFrame
        containerView.addSubview(snapshot!)
        
        toViewController.view.alpha = 0
        
        // copy and initialize all the dots
        for var index = 0; index < attendeeArray.count; ++index {
            var dotImage = dotArray[index]
            var dotImageCopy = UIImageView(image: dotImage.image)
            
            dotImageCopy.frame = dotArrayOriginFrames[index]            // position & size
            dotImageCopy.contentMode = dotImage.contentMode             // e.g. aspect fill
            dotImageCopy.clipsToBounds = dotImage.clipsToBounds         // bool value for clipping
            dotImageCopy.image = UIImage(named: attendeeArray[index])   // swap image for profile
            containerView.addSubview(dotImageCopy)
            dotArray[index] = dotImageCopy                              // probably not good practice to reuse itself
        }
        
        // animate the dots
        for var index = 0; index < attendeeArray.count; ++index {
            
            var dot = self.dotArray[index]
            var num = Double(index) + 0.25
            var clock = NSTimeInterval(num/4)
            var dotX = 25
            
            UIView.animateWithDuration(clock, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                dot.frame.origin.y = 188
                dot.frame.origin.x = 28 + (64 * CGFloat(index))
                dot.alpha = 1
            }, completion: { (Bool) -> Void in
                // code
            })
        }
        
        // scale the dots
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            for var index = 0; index < self.attendeeArray.count; ++index {
                var dot = self.dotArray[index]
                dot.transform = CGAffineTransformMakeScale(4.4, 4.4)
            }
        })
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            // code
            toViewController.view.alpha = 1
            self.snapshot?.frame = self.convertedEndFrame
        }) { (Bool) -> Void in
            // code
            self.finish()
            self.snapshot?.removeFromSuperview()
            delay(1, { () -> () in
                for var index = 0; index < self.attendeeArray.count; ++index {
                    var dot = self.dotArray[index]
                    dot.removeFromSuperview()
                }
            })
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        var tabViewController = toViewController as! TabViewController
//        var feedVC = toViewController as FeedViewController
        let navigationController = tabViewController.selectedViewController as! UINavigationController
        var feedViewController = navigationController.topViewController as! FeedViewController
        var detailsViewController = fromViewController as! DetailsViewController

        feedViewController.eventTableView.reloadData()
        
        
        convertedEndFrame = detailsViewController.endFrame
        snapshot?.frame = convertedEndFrame
        containerView.addSubview(snapshot!)
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.alpha = 0
            self.snapshot?.frame = self.convertedStartFrame
        }) { (finished: Bool) -> Void in
            self.finish()
            self.snapshot?.removeFromSuperview()
        }
    }
}
