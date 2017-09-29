//
//  Message.swift
//  TwitSplit
//
//  Created by TriNgo on 9/29/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

struct Message {
    let time: String
    let content: String
    
    init(time: String, content: String) {
        self.time = time
        self.content = content
    }
}
