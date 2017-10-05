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
    
    static func split(_ message: String, limitCharacters: Int) -> [String] {
        let error = "The message contains a span of non-whitespace characters longer than 50 characters"
        
        //Try to estimate total partial before separate
        let estTotal: Int = (message.characters.count / limitCharacters) + (message.characters.count % limitCharacters > 0 ? 1 : 0)
        
        //Separate sentences into words by remove whitespaces and new lines
        let words = message.components(separatedBy: .whitespacesAndNewlines)
        
        let errorWords = words.filter { return $0.characters.count > limitCharacters }
        
        //Return message if the length is less than limit
        guard message.characters.count > limitCharacters else { return [message] }
        
        //Return error if the length is great than limit and contains non-whitespace
        if errorWords.count > 0 { return [error] }
        
        let resultsAndBreakIndex = joinedPartial(words, estTotal: estTotal, limitCharacters: limitCharacters)
        let results = resultsAndBreakIndex.results
        
        return results
    }
    
    static func joinedPartial(_ words: [String], estTotal: Int, limitCharacters: Int) -> ResultsAndBreakIndex {
        //Initial empty string array to store all partials as output
        var results = [String]()
        var breakAtIndex = -1
        
        var resultsAndBreakIndex = (results, breakAtIndex)
        
        for i in 0..<estTotal {
            //Add indicator as suffix
            var partial = "\(i + 1)/\(estTotal) "
            var length = partial.characters.count
            
            for (index, item) in words.enumerated() {
                if index <= breakAtIndex {
                    continue
                }
                
                // Caculate string length (+ 1 because of whitespace) before joined into partial
                length += item.characters.count + 1
                
                // Break loop if length is over than limit, (+ 1 because the last whitespace)
                if length > limitCharacters + 1 {
                    break
                } else {
                    partial += item + " "
                }
                
                breakAtIndex = index
            }
            
            //Append partial
            results.append(partial.trimmingCharacters(in: .whitespaces))
        }
        
        resultsAndBreakIndex = (results, breakAtIndex)
        
        //Applied recursive to re-calculate total partials
        if breakAtIndex < words.count - 1 {
            let total = estTotal + 1
            resultsAndBreakIndex = joinedPartial(words, estTotal: total, limitCharacters: limitCharacters)
        }
        
        return resultsAndBreakIndex
    }
}
