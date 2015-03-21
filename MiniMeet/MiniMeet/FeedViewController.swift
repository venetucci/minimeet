//
//  FeedViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit


// Event Custom Struct

struct Event {
    let title: String
    let location: String
    let dateString: String
    
    var subtitle: String {
        get {
            return "\(location) • \(dateString)"
        }
    }
    
    var image: UIImage {
        get {
            let image = UIImage(named: title)
            
            if let image = image {
                return image
            } else {
                return UIImage()
            }
        }
    }
}
// End Event Custom Struct


// Classes
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    // Global Variables & Outlets
    @IBOutlet weak var eventTableView: UITableView!
    
    var events: [Event] = []
    var imageTransition: ImageTransition!
    var translationY: CGFloat!
    var translationPoint: CGPoint!
//    var scale: CGFloat!: 1
    
    
    // Load the View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
//        eventTableView.rowHeight = 190
        
    
        // Event Listings
        let technofeminism = Event(title: "Technofeminism", location: "Sightglass Coffee", dateString: "March 20, 1 pm")
        let gameOfThrones = Event(title: "Game of Thrones", location: "Blue Bottle Coffee", dateString: "April 22, 2 pm")
        let bikingInTheBay = Event(title: "Biking in the Bay", location: "Starbucks", dateString: "April 4, 3 pm")
        let iosForDesigners = Event(title: "iOS for Designers", location: "ThoughtBot", dateString: "April 10, 6 pm")
        
        // Events Array
        events = [technofeminism, gameOfThrones, bikingInTheBay, iosForDesigners]
        
        self.title = "Events"
        
        
        // Attendee Dots as Circles
        //   self.attendeeDot.layer.cornerRadius = self.attendeeDot.frame.size.width / 2;
        //   self.attendeeDot.clipsToBounds = true;
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View Method #1
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    // Table View Method #2
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Table View Method #3
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCellId") as EventCell
        let event = events[indexPath.row]
        
        cell.eventTitle.text = event.title
        cell.eventSubtitle.text = event.subtitle
        cell.eventImage.image = event.image
        
        cellTransition(cell) // Insert cell animation in the table view
        return cell
        
    }
    
    // Animate the cell
            func cellTransition(cell: UITableViewCell) {
                let view = cell.contentView
                view.transform = CGAffineTransformMakeScale(0.83, 0.83)
                view.layer.opacity = 0.9
                UIView.animateWithDuration(0.5) {
                    view.transform = CGAffineTransformMakeScale(1, 1)
                    view.layer.opacity = 1
                }
            }
    
    // Trigger cell when ready to get pushed into view
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        cellTest = cell
//        var x = translationY + CGFloat(indexPath.item * 187)
//        println( cell.frame.origin.y )
//    }
    
    
    // Scroll to get the cell frame origin value
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let niceCell = eventTableView.frame.origin.y
        translationY = scrollView.contentOffset.y + 64
        

        println("translation: \(translationY)")
        println("table view: \(eventTableView)")
    }
    
    
    
    // Segue to Event Detail Vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let cell = sender as EventCell
        let indexPath = eventTableView.indexPathForCell(cell)
        
        var destinationVC = segue.destinationViewController as DetailsViewController
        destinationVC.event = events[indexPath!.row]
        
        imageTransition = ImageTransition()
        imageTransition.snapshot = cell.snapshot()
        imageTransition.snapshotStartFrame = eventTableView.rectForRowAtIndexPath(indexPath!)
        imageTransition.duration = 0.3
        
        destinationVC.transitioningDelegate = imageTransition
        // cell.hidden = true
    }
}
