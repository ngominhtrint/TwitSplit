//
//  ViewController.swift
//  TwitSplit
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let message = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let messageArray = Utils.split(message: message)
        
        print("\(messageArray)")
    }
}

