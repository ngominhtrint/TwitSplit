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
    
    let limit = 50
    let error = ["The message contains a span of non-whitespace characters longer than 50 characters"]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTweetMessageLengthLessThanMaximum() {
        
        // Give
        let input = "Hello, Swift"
        let expected = ["Hello, Swift"]
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        // Then
        XCTAssertEqual(output.count, 1, "Should only 1 components")
        XCTAssertEqual(output, expected, "Short Message should be same the original")
    }
    
    func testTheExampleInAssigment() {
        
        // Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages, so I don't have to do it myself."]
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        // Then
        XCTAssertEqual(output.count, 2, "Should only 2 components")
        XCTAssertEqual(output, expected, "Same the expectation from the Assignment")
    }
    
    func testAnyMessageLengthExcessThanMaximum() {
        
        // Give
        let input = "Hello, Swiftabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabcabc"
        let expected = error
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testCreateTweetComponentWithNewOneCase() {
        
        // Give
        let input = "Twitter mostly uses Ruby on Rails for their front-end and primarily Scala and Java for back-end services. They use Apache Thrift (originally developed by Facebook) to communicate between different internal services."
        let expected = ["1/6 Twitter mostly uses Ruby on Rails for their",
                        "2/6 front-end and primarily Scala and Java for",
                        "3/6 back-end services. They use Apache Thrift",
                        "4/6 (originally developed by Facebook) to",
                        "5/6 communicate between different internal",
                        "6/6 services."]
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        // Then
        XCTAssertEqual(output, expected, "The last character (Service) didn't add to new component")
    }
    
    func testSplitTweetToMoreThanOneTweet() {
        
        // Give
        let input = "Facebook just switched several of its open source projects — including React — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."
        
        let expected = ["1/9 Facebook just switched several of its open",
                        "2/9 source projects — including React — over to",
                        "3/9 the popular MIT license. Before that, Facebook",
                        "4/9 was using their own custom “BSD+Patents”",
                        "5/9 license. This was similar to the widely-used",
                        "6/9 BSD license, but also included a clause that",
                        "7/9 basically said: “you can’t sue Facebook for",
                        "8/9 infringing on your patents. This license came",
                        "9/9 under fire this summer. Here’s what happened."]
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        // Then
        XCTAssertEqual(output, expected, "Split Tweet into more than one Tweet")
    }
    
    func testOneWordIsExcessMaximumCase() {
        
        // Give
        let input = "Facebook just switched several of its open source projects — including ReactReactReactReactReactReactReactReactReactReactReactReactReactReactReact — over to the popular MIT license. Before that, Facebook was using their own custom “BSD+Patents” license. This was similar to the widely-used BSD license, but also included a clause that basically said: “you can’t sue Facebook for infringing on your patents. This license came under fire this summer. Here’s what happened."
        let expected = error
        
        // When
        let output = Utils.split(input, limitCharacters: limit)
        
        // Then
        XCTAssertEqual(output, expected)
    }
    
    func testCharatersIndexAt50() {
        //Give
        let input = "I can't believe Tweeter now supports SwiftSwiftSwiftSwiftSwiftSwift my messages, so I don't have to do it myself."
        let expected = ["1/3 I can't believe Tweeter now supports",
                        "2/3 SwiftSwiftSwiftSwiftSwiftSwift my messages, so",
                        "3/3 I don't have to do it myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: limit)
        
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
        let output = Utils.split(input, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testOverThanTenParts() {
        //Give
        let input = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself. I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/11 I can't believe Tweeter now supports chunking",
                        "2/11 my messages, so I don't have to do it myself.",
                        "3/11 I can't believe Tweeter now supports chunking",
                        "4/11 my messages, so I don't have to do it myself.",
                        "5/11 I can't believe Tweeter now supports chunking",
                        "6/11 my messages, so I don't have to do it myself.",
                        "7/11 I can't believe Tweeter now supports chunking",
                        "8/11 my messages, so I don't have to do it myself.",
                        "9/11 I can't believe Tweeter now supports chunking",
                        "10/11 my messages, so I don't have to do it",
                        "11/11 myself."]
        
        //When
        let output = Utils.split(input, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testEdgeCases() {
        //Give
        let msgs = "abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^& abcdefghijilmnopqrstuvwxyz1234567890!@#$%^&22"
        let expected: [String] = []
        
        //When
        let output = Utils.split(msgs, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testInputWithMultipleWhitespaceConsistence() {
        //Give
        let input = "this     is     a   \n\n\n  possible     input"
        let expected = ["this is a possible input"]
        
        //When
        let output = Utils.split(input, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
    
    func testInputWithMultipleWhitespaceConsistenceAndGreaterThan50() {
        //Give
        let input = "I can't     believe     Tweeter     now     supports     chunking     my     messages"
        let expected = ["1/2 I can't believe Tweeter now supports chunking",
                        "2/2 my messages"]
        
        //When
        let output = Utils.split(input, limitCharacters: limit)
        
        //Then
        XCTAssertEqual(output, expected)
    }
}




