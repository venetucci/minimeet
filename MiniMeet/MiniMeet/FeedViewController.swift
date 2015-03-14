//
//  FeedViewController.swift
//  MiniMeet
//
//  Created by Hi_Hu on 3/10/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

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

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventTableView: UITableView!

    
    var events: [Event] = []
    var imageTransition: ImageTransition!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.rowHeight = 187
        
       
        
        
        
        
        let technofeminism = Event(title: "Technofeminism", location: "Sightglass Coffee", dateString: "March 20, 1 pm")
        let gameOfThrones = Event(title: "Game of Thrones", location: "Blue Bottle Coffee", dateString: "April 22, 2 pm")
        let bikingInTheBay = Event(title: "Biking in the Bay", location: "Starbucks", dateString: "April 4, 3 pm")
        
        events = [technofeminism, gameOfThrones, bikingInTheBay]
        
        self.title = "Events"
        
      
        
     //   self.attendeeDot.layer.cornerRadius = self.attendeeDot.frame.size.width / 2;
     //   self.attendeeDot.clipsToBounds = true;


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return events.count
        }
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("eventCellId") as EventCell
        let event = events[indexPath.row]
        
        cell.eventTitle.text = event.title
        cell.eventSubtitle.text = event.subtitle
        cell.eventImage.image = event.image;
        
        return cell
    }
   
    
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
