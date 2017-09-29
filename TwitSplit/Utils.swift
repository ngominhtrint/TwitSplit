//
//  Utils.swift
//  TwitSplit
//
//  Created by TriNgo on 9/27/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation

class Utils {
    
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
