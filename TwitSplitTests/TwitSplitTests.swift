//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import XCTest
@testable import TwitSplit

class TwitSplitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInputStringIsNil() {
        XCTAssertNotNil(Utils.split(message: ""))
    }
    
    func testReturnEmptyArrayWhileInputStringIsNil() {
        XCTAssertEqual(Utils.split(message: ""), [""])
    }
    
    func testCharactersLessThan50() {
        XCTAssertEqual(Utils.split(message: "I can't believe Tweeter now supports chunking").count, 1)
    }
    
    func testCharactersGreaterThan50() {
        XCTAssertEqual(Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself").count, 2)
    }
    
    func testCharactersGreaterThan150() {
        XCTAssertEqual(Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself").count, 4)
    }
    
    func testLimitCharactersForEachPart() {
        if let firstPart = Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do").first {
            XCTAssert(firstPart.characters.count <= 50)
        }
    }
    
    func testFirstPartSuffix() {
        if let firstPart = Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do").first {
            XCTAssert(firstPart.contains("1/2 "))
        }
    }
    
    func testSecondPartSuffix() {
        if Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do").count > 1 {
            let secondPart = Utils.split(message: "I can't believe Tweeter now supports chunking my messages, so I don't have to do")[1]
            XCTAssert(secondPart.contains("2/2 "))
        }
    }
}
