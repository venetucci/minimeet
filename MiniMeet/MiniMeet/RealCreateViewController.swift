//
//  RealCreateViewController.swift
//  MiniMeet
//
//  Created by dt on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class RealCreateViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    // Labels
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // Text Fileds and Views
    @IBOutlet weak var eventTitleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scrollView.contentSize = contentView.frame.size
        scrollView.contentSize = CGSize(width: 320, height: 750)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectDateDidPress(sender: AnyObject) {
        performSegueWithIdentifier("selectDateSegue", sender: self)
        
    }
    
    
    @IBAction func selectLocationDidPress(sender: AnyObject) {
        performSegueWithIdentifier("selectLocationSegue", sender: self)
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

}
