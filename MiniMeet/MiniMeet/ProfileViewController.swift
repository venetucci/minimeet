//
//  ProfileViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet var contents: UIView!
    
    var parseImage: [PFObject]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(contents.frame.size)
        scrollView.contentSize.height = 1000
                
        var query = PFQuery(className: "Profile")
        query.getObjectInBackgroundWithId("ffpDeTzNl1") {
            (profileObject, error) in
            if error == nil && profileObject != nil {
                println(profileObject)
            } else {
                println(error)
            }

            if let profileObject = profileObject,
                userImageFile = profileObject["profile_image"] as? PFFile {
                userImageFile.getDataInBackgroundWithBlock {
                    (imageData, error) in
                    if let imageData = imageData {
                        let image = UIImage(data:imageData)
                        self.profileImage.image = image
                    }
                }
            } else {
                print("Error getting profile image")
            }
        }

        viewLabel.attributedText = NSMutableAttributedString(string: "PROFILE", attributes: [NSKernAttributeName: 4] )
        profileName.attributedText = NSMutableAttributedString(string: "Michelle Venetucci", attributes: [NSKernAttributeName: 4] )
        configureDescription()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureDescription() {
        var paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineSpacing = 4.0
        var attributes = [NSParagraphStyleAttributeName: paragraphStyle]
        var attributedString = NSAttributedString(string: descriptionText!.text!, attributes: attributes)
        descriptionText.attributedText = attributedString
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

}
