//
//  Utils.swift
//  TwitSplit
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class Utils {
    
    typealias ResultsAndBreakIndex = (results: [String], breakIndex: Int)
    
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
        var estTotal: Int = (message.characters.count / limitCharacters) + (message.characters.count % limitCharacters > 0 ? 1 : 0)
        
        //Separate sentences into words by remove whitespaces and new lines
        let words = message.components(separatedBy: .whitespacesAndNewlines)
        
        let resultsAndBreakIndex = joinedPartial(words, estTotal: estTotal, limitCharacters: limitCharacters)
        var results = resultsAndBreakIndex.results
    
        if resultsAndBreakIndex.breakIndex < words.count - 1 {
            estTotal = estTotal + 1
            results = joinedPartial(words, estTotal: estTotal, limitCharacters: limitCharacters).results
        }

        return results
    }
    
    static func joinedPartial(_ words: [String], estTotal: Int, limitCharacters: Int) -> ResultsAndBreakIndex {
        //Initial empty string array to store all partials as output
        var results = [String]()
        
        var breakAtIndex = 0
        
        for i in 0..<estTotal {
            //Add indicator as suffix
            var partial = "\(i + 1)/\(estTotal) "
            var length = partial.characters.count
            
            for (index, item) in words.enumerated() {
                if index < breakAtIndex {
                    continue
                }
                
                // Caculate string length (+ 1 because of whitespace) before joined into partial
                length += item.characters.count + 1
                
                // Break loop if length is over than limit
                if length > limitCharacters {
                    breakAtIndex = index
                    break
                } else {
                    partial += item + " "
                }
            }
            
            //Append partial
            results.append(partial.trimmingCharacters(in: .whitespaces))
        }
        
        return (results, breakAtIndex)
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
