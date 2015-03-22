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
    
    var convertedStartFrame = CGRectZero
    var convertedEndFrame = CGRectZero
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var tabViewController = fromViewController as TabViewController
        let navigationController = tabViewController.selectedViewController as UINavigationController
        var feedViewController = navigationController.topViewController as FeedViewController
        
        var detailsViewController = toViewController as DetailsViewController
        
        convertedStartFrame = containerView.convertRect(snapshotStartFrame, fromView: feedViewController.eventTableView)
        convertedEndFrame = containerView.convertRect(detailsViewController.containerView.frame, fromView: detailsViewController.view)
        
        snapshot?.frame = convertedStartFrame
        containerView.addSubview(snapshot!)
        
        toViewController.view.alpha = 0
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.alpha = 1
            self.snapshot?.frame = self.convertedEndFrame
        }) { (finished: Bool) -> Void in
            self.finish()
            self.snapshot?.removeFromSuperview()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        var tabViewController = toViewController as TabViewController
        let navigationController = tabViewController.selectedViewController as UINavigationController
        var feedViewController = navigationController.topViewController as FeedViewController
        
        var detailsViewController = fromViewController as DetailsViewController

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
