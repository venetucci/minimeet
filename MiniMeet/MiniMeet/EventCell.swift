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
    @IBOutlet weak var eventImage: UIImageView!
    
    
    // 
    
        // Initialization code
    
    
    func snapshot() -> UIView {
        return snapshotViewAfterScreenUpdates(false)
    }
}

