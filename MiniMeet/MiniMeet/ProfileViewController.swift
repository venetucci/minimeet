//
//  ProfileViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileFeed: UIImageView!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var profileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLabel.attributedText = NSMutableAttributedString(string: "PROFILE", attributes: [NSKernAttributeName: 4] )
        profileName.attributedText = NSMutableAttributedString(string: "JON SNOW", attributes: [NSKernAttributeName: 5] )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

}
