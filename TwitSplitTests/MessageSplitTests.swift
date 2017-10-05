//
//  MessageSplitTests.swift
//  TwitSplit
//
//  Created by TriNgo on 10/4/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import XCTest
@testable import TwitSplit

class MessageSplitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMessageLengthLessThanLimit() {
        //Give
        let input = "I can't believe Tweeter"
        let expected = ["I can't believe Tweeter"]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testMessageNonWhitespaceAndGreaterThanLimit() {
        //Give
        let input = "Ican'tbelieveTweeternowsupportschunkingmymessages,so"
        let expected = ["The message contains a span of non-whitespace characters longer than 50 characters"]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testSplitAsPartialWithIndicator() {
        
        //Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testCharatersIndexAt50() {
        //Give
        let input = "I can't believe Tweeter now supports SwiftSwiftSwiftSwiftSwiftSwift my messages, so I don't have to do it myself."
        let expected = ["1/3 I can't believe Tweeter now supports",
                        "2/3 SwiftSwiftSwiftSwiftSwiftSwift my messages,",
                        "3/3 so I don't have to do it myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testOverThanTenParts() {
        //Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/10 I can't believe Tweeter now supports chunking",
                        "2/10 my messages, so I don't have to do it myself.",
                        "3/10 I can't believe Tweeter now supports chunking",
                        "4/10 my messages, so I don't have to do it myself.",
                        "5/10 I can't believe Tweeter now supports chunking",
                        "6/10 my messages, so I don't have to do it myself.",
                        "7/10 I can't believe Tweeter now supports chunking",
                        "8/10 my messages, so I don't have to do it myself.",
                        "9/10 I can't believe Tweeter now supports chunking",
                        "10/10 my messages, so I don't have to do it myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testTotalPartIsGreaterThanEstimate() {
        //Give
        let input = "I can't believe Tweeter now supports chunkingchunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunkingchunking my messages, so I don't have to do it myself."
        let expected = ["1/5 I can't believe Tweeter now supports",
                        "2/5 chunkingchunking my messages, so I don't have",
                        "3/5 to do it myself. I can't believe Tweeter now",
                        "4/5 supports chunkingchunking my messages, so I",
                        "5/5 don't have to do it myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: 50)
        
        //Then
        XCTAssertEqual(output, expected)
    }
}




