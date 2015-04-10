//
//  FeedViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit
import Parse

// Event Custom Struct
struct Event {
    
    let title: NSString
    let description: String
    let location: String
    let dateString: String
    let timeString: String
    var attendeeArray: [String]     // an array of names
//    var eventImageName: String
    var eventImage: UIImage
    
    var subtitle: String {
        get {
            return "\(dateString)"
        }
    }
    
    var eventTime: String {
        get {
            return "\(timeString)"
        }
    }
    
    var eventLocation: String {
        get {
            return "\(location)"
        }
    }
    
//    var image: UIImage {
//        get {
//            let image = UIImage(named: eventImageName)
//            
//            if let image = image {
//                return image
//            } else {
//                return UIImage()
//            }
//        }
//    }
}
// End Event Custom Struct

// Classes
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
        
    // Global Variables & Outlets
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var viewLabel: UILabel!
    
    var events: [Event] = []
    var imageTransition: ImageTransition!
    var translationY: CGFloat!
    var translationPoint: CGPoint!
    var dotFrameArray: [CGRect] = [CGRectZero, CGRectZero, CGRectZero, CGRectZero, CGRectZero] // empty dot array for the frame positions
    
    // Load the View
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        
        // set the label
        viewLabel.attributedText = NSMutableAttributedString(string: "BROWSE", attributes: [NSKernAttributeName: 4] )

        // Event Listings
        var query = PFQuery(className: "Events")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let event = objects as? [PFObject] {
                    for event in objects {
                        
                        
                        var event_name = event["event_name"]! as NSString
                        var event_description = event["event_desc"]! as NSString
                        var event_location = event["event_location"]! as NSString
                        var event_attd = event["event_attd"]! as [String]
                        
                        var event_image: UIImage!
                        
                        var event_imageFile = event["event_image"]! as PFFile
                        event_imageFile.getDataInBackgroundWithBlock {
                            (imageData: NSData!, error: NSError!) -> Void in
                            if error == nil {
                                event_image = UIImage(data:imageData)! as UIImage
                                //                                println(event_image)
                                
                                var eventStruct = Event(
                                    title: event_name,
                                    description: event_description,
                                    location: event_location,
                                    dateString: "1",
                                    timeString: "2",
                                    attendeeArray: event_attd,
                                    eventImage: event_image
                                )
                                
                                self.events.append(eventStruct)
                                println(self.events.count)
                            }
                        }
                        //                        println(event.objectId)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        println("here \(self.events.count)")
        
//        let iosForDesigners = Event(
//            title: "iOS FOR DESIGNERS",
//            description: "Designers talk and learn about prototyping iOS apps with Swift and Xcode. There is a focus on views, navigation, transitions, and animations. We'll also look into the Apple Watch and talk about how we can start making useful apps for it. ",
//            location: "thoughtbot",
//            dateString: "3.28.15",
//            timeString: "1:30 pm",
//            attendeeArray: ["mich","danny","hanna"],
//            eventImageName: "ios-for-designers"
//        )

//        // Events Array
//        events = [nerdFun, photowalk, midnightRide, technofeminism, justMoved, cocoaPods, handLettering, hackersFounders, digitalMusic]
    }
    
    override func viewWillAppear(animated: Bool) {
        // code
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View Method #1
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Table View Method #2
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    // Table View Method #3
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCellId") as EventCell
        let event = events[indexPath.row]
        
        // apply kerning to the title
        var mutableString = NSMutableAttributedString(string: event.title, attributes: [NSKernAttributeName: 4] )

        cell.eventTitle.numberOfLines = 2
        cell.eventTitle.lineBreakMode =  NSLineBreakMode.ByWordWrapping
        cell.eventTitle.attributedText = mutableString
        cell.eventSubtitle.text = event.dateString
        cell.eventTime.text = event.timeString
        cell.eventLocation.text = event.location
        cell.eventImage.image = event.eventImage
        cell.eventAttendees = event.attendeeArray
        cell.resetAttendees()
        cell.displayAttendees()
        cellTransition(cell) // Insert cell animation in the table view
        return cell
    }

    @IBAction func didPressProfileButton(sender: AnyObject) {
        performSegueWithIdentifier("profileSegue", sender: self)
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
    
    // Scroll to get the cell frame origin value
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let niceCell = eventTableView.frame.origin.y
        translationY = scrollView.contentOffset.y + 64
    }
    
    @IBAction func createButtonDidPress(sender: AnyObject) {
        // button is directly linked no need for action
    }
    
    // Segue to Event Detail Vc
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if sender.isMemberOfClass(EventCell) {
            let cell = sender as EventCell
            let indexPath = eventTableView.indexPathForCell(cell)
            
            var destinationVC = segue.destinationViewController as DetailsViewController
            destinationVC.event = events[indexPath!.row]
            
            // pass the frames of each dot into the dotFrameArray
            for var index = 0; index < cell.dotArray.count; ++index {
                var dotFrame = view.convertRect(cell.frame, fromView: eventTableView)
                dotFrame.origin.x = dotFrame.origin.x + cell.dotArray[index].frame.origin.x
                dotFrame.origin.y = dotFrame.origin.y + cell.dotArray[index].frame.origin.y
                dotFrame.size.width = cell.dotArray[index].frame.width
                dotFrame.size.height = cell.dotArray[index].frame.height
                dotFrameArray[index] = dotFrame
            }
            
            imageTransition = ImageTransition()
            imageTransition.attendeeArray = cell.eventAttendees
            imageTransition.snapshot = cell.eventContainer.snapshotViewAfterScreenUpdates(true)
            imageTransition.dotArray = cell.dotArray
            imageTransition.dotArrayOriginFrames = dotFrameArray
            imageTransition.snapshotStartFrame = eventTableView.rectForRowAtIndexPath(indexPath!)
            imageTransition.duration = 0.5
            
            destinationVC.transitioningDelegate = imageTransition
            
        } else {
            // it is not a tableCell so don't do anything (yet)
        }
    }
}
