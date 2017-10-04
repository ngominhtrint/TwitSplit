//
//  Utils.swift
//  TwitSplit
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class Utils {
    
    // Using regex but wrong approach
    static func split(message: String) -> [String] {
        
        let error = ["The message contains a span of non-whitespace characters longer than 50 characters"]
        var hasError = false
        
        if message.characters.count < 50 {
            return [message]
        }
        var messageArray = [String]()
        let messageRegexes = message.match(for: "(\\b.{1,45}(\\s|$))\\s*")
        if messageRegexes.count > 1 {
            for (index, string) in messageRegexes.enumerated() {
                if string.characters.count > 50 {
                    hasError = true
                }

                if hasError {
                    return error
                } else {
                    messageArray.append("\(index + 1)/\(messageRegexes.count) \(string.trimmingCharacters(in: .whitespacesAndNewlines))")
                }
            }
        } else {
            return error
        }
        
        return messageArray
    }
    
    static func split(_ message: String, limitCharacters: Int) -> [String] {
        let error = "The message contains a span of non-whitespace characters longer than 50 characters"
        
        //Return message if the length is less than limit
        if message.characters.count < limitCharacters {
            return [message]
        }
        
        //Return error if the length is great than limit and contains non-whitespace
        if message.characters.count > limitCharacters && !message.contains(" ") {
            return [error]
        }
        
        //Try to estimate total partial before separate
        let estTotal: Int = (message.characters.count / limitCharacters) + (message.characters.count % limitCharacters > 0 ? 1 : 0)
        
        //Separate sentences into words by remove whitespaces and new lines
        var words = message.components(separatedBy: .whitespacesAndNewlines)
        
        var results = [String]()
        
        for index in 0..<estTotal {
            //Add indicator as suffix
            var partial = "\(index + 1)/\(estTotal) "
            
            for item in words {
                //Joined words into sentence with less than limit characters condition
                if partial.characters.count < limitCharacters {
                    partial += item + " "
                    
                    //Remove words that already appended into partial
                    words.remove(at: 0)
                } else {
                    break
                }
            }
            
            //Append partial
            results.append(partial.trimmingCharacters(in: .whitespaces))
        }
    
        return results
    }
}

extension String {
    
    func match(for regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
            let nsString = self as NSString
            let results = regex.matches(in: self, options: .anchored, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range) }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
