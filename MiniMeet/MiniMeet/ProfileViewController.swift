//
//  ProfileViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var contents: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(contents.frame.size)
        scrollView.contentSize.height = 1000
        
        viewLabel.attributedText = NSMutableAttributedString(string: "PROFILE", attributes: [NSKernAttributeName: 4] )
        profileName.attributedText = NSMutableAttributedString(string: "JON SNOW", attributes: [NSKernAttributeName: 4] )
        configureDescription()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureDescription() {
        var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as NSMutableParagraphStyle
        paragraphStyle.lineSpacing = 4.0
        var attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        var attributedString = NSAttributedString(string: descriptionText!.text!, attributes: attributes)
        descriptionText.attributedText = attributedString
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

}
