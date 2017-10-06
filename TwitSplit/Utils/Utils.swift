//
//  Utils.swift
//  TwitSplit
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class Utils {
    
    static func split(_ input: String, limitCharacters: Int) -> [String] {
        
        //Initialize non-whitespace error message
        let error = "The message contains a span of non-whitespace characters longer than \(limitCharacters) characters"
        
        //Condensed whitespace
        let message = input.condensedWhitespace
        
        //Return message if the length is less than limit
        guard message.count > limitCharacters else { return [message] }
        
        //Try to estimate total partial before separate
        let estTotal: Int = (message.count / limitCharacters) + (message.count % limitCharacters > 0 ? 1 : 0)
        
        //Separate sentences into words by remove whitespaces and new lines
        let words = message.components(separatedBy: .whitespacesAndNewlines)
        
        //Each word length should greater than limit
        let errorWords = words.filter { return $0.count > limitCharacters }

        //Return error if the length is great than limit and contains non-whitespace
        guard errorWords.count <= 0 else { return [error] }
        
        //Return tweets message
        return joinedPartial(words, estTotal: estTotal, limitCharacters: limitCharacters)
    }
    
    static func joinedPartial(_ words: [String], estTotal: Int, limitCharacters: Int) -> [String] {
        
        //Initial empty string array to store all partials as output
        var results = [String]()
        var breakAtIndex = -1
        
        for i in 0..<estTotal {
            //Append indicator as prefix
            var partial = "\(i + 1)/\(estTotal) "
            let indicatorLength = partial.count
            var length = partial.count
            
            // Go through individual word
            for (index, item) in words.enumerated() {
                
                //Return empty array if the length of individual word include indicator greater than limit
                guard item.count + indicatorLength <= limitCharacters else { return [] }
                
                // Skip words that already joined into partial
                guard index > breakAtIndex else { continue }
                
                // Pre-caculate how much partial length (+ 1 because of 1 suffix whitespace per word) before joined into partial
                length += item.count + 1
                
                // Break loop if length is over than limit, (+ 1 because the last whitespace before trimming)
                guard length <= limitCharacters + 1 else { break }
                
                //Append individual word after prefix indicator
                partial += item + " "
                
                //Store current index where the last word is appended
                breakAtIndex = index
            }
            
            //Append partial
            results.append(partial.trimmingCharacters(in: .whitespaces))
        }
        
        //Applied recursive to re-calculate total partials
        if breakAtIndex < words.count - 1 {
            let total = estTotal + 1
            results = joinedPartial(words, estTotal: total, limitCharacters: limitCharacters)
        }
        
        return results
    }
}

extension String {
    
    var condensedWhitespace: String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    //Make characters count shorter
    var count: Int {
        return self.characters.count
    }
}
