//
//  HomeCell.swift
//  TwitSplit
//
//  Created by TriNgo on 9/29/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    var message: Message! {
        didSet {
            timeLabel.text = message.time
            messageLabel.text = message.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
