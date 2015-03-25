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
    
    let title: NSString
    let description: String
    let location: String
    let dateString: String
    let timeString: String
    var attendeeArray: [String]     // an array of names
    var eventImageName: String
    
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
    
    var image: UIImage {
        get {
            let image = UIImage(named: eventImageName)
            
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
        let nerdFun = Event(
            title: "NERD FUN",
            description: "You like learning things, going to museums, science lectures, and you can't get your regular crew to go with you. Perhaps you went to engineering school, but you use hair conditioner anyway. You're intelligent and you have social skills, even tho you might have a video game or two on your hard drive. If you're willing to let your geek flag fly, please join us.",
            location: "Sightglass Coffee",
            dateString: "3.20.15",
            timeString: "1:00 pm",
            attendeeArray: ["danny","hanna","joe","mich"],
            eventImageName: "nerd-fun"
        )
        
        let photowalk = Event(
            title: "LANDS END PHOTOWALK",
            description: "Just bring something to take pictures with (any and all devices welcome all levels are encouraged, I myself am a perpetual beginner) and come on a photo walk. We'll convene at a checkpoint, then go for an hour or so photowalk. We'll end at a cafe, where we can sip a beverage, share tips, edit pictures, upload to a social networking sites.",
            location: "Four Barrel Coffee",
            dateString: "3.27.15",
            timeString: "3:30 pm",
            attendeeArray: ["joe","mike","mich","jon","hanna"],
            eventImageName: "lands-end-photowalk"
        )
        
        let midnightRide = Event(
            title: "MIDNIGHT MYSTERY RIDE",
            description: "It’s kind of a flash mob in that dozens of total strangers converge at a location (announced the day of the ride).  We are an adhoc group of anyone dastardly enough to show up for the midnight ride.  12 months out of the year, we meet up at midnight then follow the leader to a secret mystery location.",
            location: "Starbucks",
            dateString: "3.29.15",
            timeString: "4:45 pm",
            attendeeArray: ["mich","hanna","danny"],
            eventImageName: "midnight-mystery-ride"
        )
        
        let technofeminism = Event(
            title: "TECHNOFEMINISM",
            description: "Technofeminism is global 501(c)(3) non-profit inspiring women to excel in technology careers with 20,000+ members in 50 cities spanning 15 countries (and counting). Women are invited to come learn about coding.",
            location: "Ferry Building Benches",
            dateString: "3.28.15",
            timeString: "12:00 pm",
            attendeeArray: ["mich"],
            eventImageName: "technofeminism"
        )
        
        let iosForDesigners = Event(
            title: "iOS FOR DESIGNERS",
            description: "Designers talk and learn about prototyping iOS apps with Swift and Xcode. There is a focus on views, navigation, transitions, and animations. We'll also look into the Apple Watch and talk about how we can start making useful apps for it. ",
            location: "thoughtbot",
            dateString: "3.28.15",
            timeString: "1:30 pm",
            attendeeArray: ["mich","danny","mike","joe","hanna"],
            eventImageName: "ios-for-designers"
        )
        
        let justMoved = Event(
            title: "JUST MOVED 2 SF",
            description: "New to the Valley and interested in technology startups? This meetup helps you interact with like minded people. Discover new places, learn from the experiences of others, connect with similar folks and get best practices for navigating and excelling within the Silicon Valley ecosystem.",
            location: "Sightglass Coffee",
            dateString: "4.1.15",
            timeString: "2:30 pm",
            attendeeArray: ["jon","mike","hanna","joe","danny"],
            eventImageName: "just-moved-to-sf"
        )
        
        let cocoaPods = Event(
            title: "COCOAPODS",
            description: "CocoaPods helps developers build apps with Swift and Objective-C. It has thousands of libraries and can help you scale your projects elegantly. We started a group for CocoaPods authors and users in San Francisco, so come by to talk about how you are using CocoaPods in your project or to learn how to do it!",
            location: "Dandelion Chocolate",
            dateString: "4.4.15",
            timeString: "1:45 pm",
            attendeeArray: ["hanna","joe","danny","mich","jon"],
            eventImageName: "cocoapods"
        )
        
        let handLettering = Event(
            title: "HAND LETTERING",
            description: "This month's event is themed around using lettering to raise awareness for charities here in Portland that could use some exposure and positive vibes. We will be selecting 5 charities to create lettered artwork for the night of the event, and when you arrive, you'll be able to choose a team to join.",
            location: "Pica Pica",
            dateString: "3.28.15",
            timeString: "1:00 pm",
            attendeeArray: ["mich","mike","danny","hanna","joe"],
            eventImageName: "hand-lettering"
        )
        
        let hackersFounders = Event(
            title: "HACKERS AND FOUNDERS",
            description: "Hackers and Founders started with a small group of only five members, but the combination of beer, burgers and talk about big problems proved potent. We've grown to over 150,000 members, but wanted to run some Mini Meets to go back to our roots and start with five people sitting around a table talking about big problems.",
            location: "Red Door",
            dateString: "4.2.15",
            timeString: "3:30 pm",
            attendeeArray: ["joe","hanna","danny","mich","mike"],
            eventImageName: "hackers-and-founders"
        )
        
        let digitalMusic = Event(
            title: "DIGITAL MUSIC PRODUCTION",
            description: "We are a small group of music producers and musicians looking to collaborate with like minded cats. We have a large venue and a well suited recording studio. We create music in many genres and also mash many up. Rock, Hip-Hop, House, Drum and Bass, Acoustic and Orchestral compositions.",
            location: "Barbacco",
            dateString: "3.30.15",
            timeString: "5:30 pm",
            attendeeArray: ["danny","hanna","jon","joe","mike"],
            eventImageName: "digital-music-production"
        )
        
        // Events Array
        events = [nerdFun, photowalk, midnightRide, technofeminism, iosForDesigners, justMoved, cocoaPods, handLettering, hackersFounders, digitalMusic]
    
        self.title = "Events"
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
        var mutableString = NSMutableAttributedString(string: event.title, attributes: [NSKernAttributeName: 8] )

        cell.eventTitle.numberOfLines = 2
        cell.eventTitle.lineBreakMode =  NSLineBreakMode.ByWordWrapping
        cell.eventTitle.attributedText = mutableString
        cell.eventSubtitle.text = event.dateString
        cell.eventTime.text = event.timeString
        cell.eventLocation.text = event.location
        cell.eventImage.image = event.image
        cell.eventAttendees = event.attendeeArray
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
