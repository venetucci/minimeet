//
//  EventDetailViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var attendModal: UIView!
    @IBOutlet weak var successImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attendModal.alpha = 0
        successImage.transform = CGAffineTransformMakeScale(0.5, 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backDidPress(sender: AnyObject) {
        navigationController!.popViewControllerAnimated(true)
    }

    @IBAction func attendDidPress(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.attendModal.alpha = 1
            self.successImage.transform = CGAffineTransformMakeScale(1, 1)
        })
    }
    
    override func viewWillAppear(animated: Bool) {
        // code
        self.tabBarController?.tabBar.hidden = true
    }
    
    @IBAction func didTap(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.attendModal.alpha = 0
            self.successImage.transform = CGAffineTransformMakeScale(0.5, 0.5)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
