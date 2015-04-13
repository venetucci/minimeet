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
class Event {
    
    let objectId: NSString = ""
    let title: NSString = ""
    let description: String = ""
    let location: String = ""
    let dateString: String = ""
    let timeString: String = ""
    var attendeeArray: [String] = []     // an array of names
    var eventImage: UIImage?
    var eventImageFile: PFFile
    
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
    
    init(parseObject: PFObject) {
        objectId = parseObject.objectId! as String
        title = parseObject["event_name"]! as String
        title = title.uppercaseString
        description = parseObject["event_desc"]! as String
        location = parseObject["event_location"]! as String
        dateString = getDate(parseObject["event_date"]! as NSDate)
        timeString = getTime(parseObject["event_date"]! as NSDate)
        attendeeArray = parseObject["event_attd"]! as [String]
        eventImageFile = parseObject["event_image"] as PFFile
    }
}

func getDate(date: NSDate) -> String {
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    var eventDate = dateFormatter.stringFromDate(date)
    return eventDate
}

func getTime(time: NSDate) -> String {
    var dateFormatter = NSDateFormatter()
    dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    var eventTime = dateFormatter.stringFromDate(time)
    return eventTime
}

// Classes
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, CreateViewControllerDelegate {
        
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

        // query Parse for events
        var query = PFQuery(className: "Events")
        query.orderByDescending("createdAt")
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                println("Successfully retrieved \(objects.count) scores.")
                // Do something with the found objects
                if let event = objects as? [PFObject] {
                    for event in objects {
                        
                        let eventStruct = Event(parseObject: event as PFObject)
                        // add the structure to the array of events
                        self.events.append(eventStruct)
                        
                        // refresh the tableView
                        self.eventTableView.reloadData()
                        
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // fetch the new event here!
        self.eventTableView.reloadData()
        println("-------------- about to load ------------")
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
        var event = events[indexPath.row]
        
        // apply kerning to the title
        var mutableString = NSMutableAttributedString(string: event.title, attributes: [NSKernAttributeName: 4] )
        
        if event.eventImage == nil {
            cell.eventImage.image = UIImage(named: "eventPlaceholder")
            event.eventImageFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                event.eventImage = UIImage(data: data)
                cell.eventImage.image = UIImage(data: data)
            })
        } else {
            cell.eventImage.image = event.eventImage
        }

        cell.eventTitle.numberOfLines = 2
        cell.eventTitle.lineBreakMode =  NSLineBreakMode.ByWordWrapping
        cell.eventTitle.attributedText = mutableString
        cell.eventSubtitle.text = event.dateString
        cell.eventTime.text = event.timeString
        cell.eventLocation.text = event.location
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
            
        } else if segue.identifier == "createEventSegue" {
            var viewController = segue.destinationViewController as RealCreateViewController
            viewController.delegate = self
        }
    }
    
    func createViewController(viewcontroller: RealCreateViewController, didCreateEvent event: PFObject) {
        eventTableView.contentOffset = CGPointZero
        dismissViewControllerAnimated(true) { () -> Void in
            self.events.insert(Event(parseObject: event), atIndex: 0)

            let indexPaths = [NSIndexPath(forRow: 0, inSection: 0)]
            self.eventTableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
}
