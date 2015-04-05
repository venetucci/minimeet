//
//  SelectLocationViewController.swift
//  MiniMeet
//
//  Created by dt on 3/24/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

// Add protocol and delegate
protocol VenueEntryDelegate {
    func UserDidInputInfoVenue(info:NSString)
}

class SelectLocationViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning, UITableViewDataSource, UITableViewDelegate {
    
    // Custom Presenting
    var isPresenting: Bool = true
    
    var items: [NSDictionary]! = [] // This is your property
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationLabel: UILabel! = UILabel()
    
    // Declare Pass Data Delegate
    var passVenueDataDelegate: VenueEntryDelegate? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Datasource & Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // FOURSQUARE NETWORK REQUEST
        
        var clientId = "IGUHLSKLHZZ5JXA30TT0DNXVGPGQWRZQS1RBA5RBMS1K5GLA"
        var clientSecret = "ZGLNT1RJWNU5H1TLQ5HMS2QFQGRHBR5QTU451JILSOIYTIMY"
        var foursquareVersion = "20130815"
        var latitudeLong = "37.770802,-122.403902" // Zynga HQ in CA
        var section = "coffee"
        
        var url = NSURL(string: "https://api.foursquare.com/v2/venues/explore?client_id=\(clientId)&client_secret=\(clientSecret)&v=\(foursquareVersion)&ll=\(latitudeLong)&section=\(section)")!
        var request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            // Dictionaries are like ogres. Unwrap the layers.
            var dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            var response = dictionary["response"] as NSDictionary
            var groups = response["groups"] as NSArray
            if groups.count > 0 {
                var group = groups[0] as NSDictionary // This should grab the "recommended" group
                var items = group["items"] as NSArray
                self.items = group["items"] as [NSDictionary]
                
                for item in self.items {
                    var venue = item["venue"] as NSDictionary
                    var name = venue["name"] as String
                    self.tableView.reloadData()
                    
                    println(url)
                    
                }
            }
        }
        
        
        // END NETWORK REQUEST

        // Do any additional setup after loading the view.
    }
    
    
    // Methods: Custom Transition
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 0.95
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                fromViewController.view.alpha = 0
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
    
    // End Custom Transition Methods

    
    // Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("VenueTableViewCell") as VenueTableViewCell
        
        // Customize the cell with the Foursquare data
        println(indexPath.row)
        var item = self.items[indexPath.row]
        var venue = item["venue"] as NSDictionary
        var name = venue["name"] as String
        cell.textLabel?.text = name
        
        // Set the selected row as the Location Label
//        self.locationLabel.text = name
        
        println(name)
        return cell

    }
    
    // Select the Cell Row & Selected Location
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        let text = cell?.textLabel?.text
        
        if let text = text
        
        {
            self.locationLabel.text = text
            println(text)
        }
    }
    
    // Custom Transition
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var destinationVC = segue.destinationViewController as UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
    }
    
    
    // Save Button
    @IBAction func saveButtonDidPress(sender: AnyObject) {
        if (passVenueDataDelegate != nil) {
            let information: NSString = locationLabel.text!
            passVenueDataDelegate!.UserDidInputInfoVenue(information)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
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

