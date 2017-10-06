# TwitSplit
If you're curious enough please take a look on [Zalora pre-interview assignment](https://drive.google.com/file/d/0B-1eBVpxwL0ZLUJJTFNPRXJVQnM/view?usp=sharing)

## Write some test cases
At the beginning, I think it's not really complex problem, just working with string and do some split function.

Problem becomes harder and tricky when I tried to figure out and write some test cases. The total part of message, the length of prefix indicator will change by runtime and depend on length of input message.

Another problem is we can only split at whitespaces.

Let look at [test cases](https://github.com/ngominhtrint/TwitSplit/blob/master/TwitSplitTests/MessageSplitTests.swift) to know how the problem is complex.

## Using regexes - first approach but wrong

```
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
```

Let take a look on failure cases to know why regexes is wrong approach.
 
  - Be not able to split a message what is longer than 10 parts (50 characters per part)
  - Be not able to re-calculate total parts after indicator increases. For example, 1/10 (4 characters) vs 10/10 (5 characters)
  - Be not able to append last word into new partial.
  - Many anothers [cases](https://github.com/ngominhtrint/TwitSplit/blob/master/TwitSplitTests/MessageSplitTests.swift)
  
### Using recursive, re-calculate total part, re-render prefix indicator

  - Try to estimate total partial before separate.
  - Separate sentences into words by remove whitespaces and new lines.
  - Return message if the length is less than limit.
  - Return error if the length is great than limit and contains non-whitespace.
  - Add indicator as suffix of each partial.
  - Loop through all words:
    - Joined words into partial.
    - Skip words that already joined into partial.
    - Break loop if length is over than limit.
  - Append partial.
  - If still have words, applied recursive to re-calculate total partials by increasing one.

  Checkout `joinedPartial` function
  
  ```
  static func joinedPartial(_ words: [String], estTotal: Int, limitCharacters: Int) -> ResultsAndBreakIndex {
        //Initial empty string array to store all partials as output
        var results = [String]()
        var breakAtIndex = -1
        
        var resultsAndBreakIndex = (results, breakAtIndex)
        
        for i in 0..<estTotal {
            //Add indicator as suffix
            var partial = "\(i + 1)/\(estTotal) "
            let indicatorLength = partial.characters.count
            var length = partial.characters.count
            
            for (index, item) in words.enumerated() {
                
                if item.characters.count + indicatorLength > 50 {
                    return ([], index)
                }
                
                // Skip words that already joined into partial
                if index <= breakAtIndex { continue }
                
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
  ```


