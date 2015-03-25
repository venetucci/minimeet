//
//  EventCell.swift
//  MiniMeet
//
//  Created by Michelle Venetucci Harvey on 3/14/15.
//  Copyright (c) 2015 hi_hu. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSubtitle: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventContainer: UIView!
    @IBOutlet var dotArray: [UIImageView]!
    var eventAttendees: [String]!

    func resetAttendees() {
        for var index = 0; index < dotArray.count; ++index {
            dotArray[index].alpha = 0
        }
    }
    
    func displayAttendees() {
        for var index = 0; index < eventAttendees.count; ++index {
            dotArray[index].alpha = 1
        }
    }
    
    // Initialization code
    func snapshot() -> UIView {
        return snapshotViewAfterScreenUpdates(false)
    }
}