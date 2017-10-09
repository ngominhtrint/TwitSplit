# TwitSplit
Zalora pre-interview assignment

## Requirement
If you're curious enough please contact Zalora to know exactly the problem.

## System
- iOS >= 10.3
- Swift 3.0

## What I've done
- TwitSplit algorithm.
- Unit test.
- Documentation.

## How TwitSplit works?

### 1st approach: Using regexes

Let take a look on failure cases to know why regexes is wrong approach. [Checkout here](https://github.com/ngominhtrint/TwitSplit/blob/f7d9a4b51da0354f2e7695d284b40d49acde50ed/TwitSplit/Utils/Utils.swift#L16)
 
  - Be not able to split a message what is longer than 10 parts (50 characters per part)
  - Be not able to re-calculate total parts after indicator increases. For example, 1/10 (4 characters) vs 10/10 (5 characters)
  - Be not able to append last word into new partial.
  - Many anothers [test cases](https://github.com/ngominhtrint/TwitSplit/blob/master/TwitSplitTests/MessageSplitTests.swift)
  
### 2nd approach: Using recursive, re-calculate total part, re-render prefix indicator

  - **Step 1:** Condensed whitespaces and newlines characters from input message.
  - **Step 2:** Return original input message if it's less than limit characters.
  - **Step 3:** Estimate total partial before separate.
  - **Step 4:** Seperate input message into individual words by checking each word's length should greater than limit.
  - **Step 5:** Render all partials. 
  
  [Checkout](https://github.com/ngominhtrint/TwitSplit/blob/master/TwitSplit/Utils/Utils.swift#L13) `split` function
    
### Render all partials 

- **Step 5.1:** Append indicator as prefix of partials.
- **Step 5.2:** Go through individual word.
- **Step 5.3:** Return empty array if the length of individual word include indicator greater than limit.
- **Step 5.4:** Skip words that already joined into partial. Then, pre-calculate how much partial's length before join.
- **Step 5.5:** Break loop if partial's length is over than limit.
- **Step 5.6:** Append individual word.
- **Step 5.7:** Store current index where the last word is appended.

=> Applied **_recursive_** to re-calculate total partials, if it still remains words, else return.

[Checkout](https://github.com/ngominhtrint/TwitSplit/blob/master/TwitSplit/Utils/Utils.swift#L40) `joinedPartial` function

### Time complexity

In general, the time complexity is `O(n2)`. Follow this formula to calculate `estTotal`

```
estTotal = inputMessage’s length / limit + 1
```

So, the `estTotal` changes while input message's length is changed, and the worst case scenario happens if `limit` equal to 1. Then we need to loop through `estTotal * inputMessage's length` times. 

```
// Go through 0 to total partial
for i in 0..<estTotal {
    //...
    //...
            
    // Go through individual word
    for (index, item) in words.enumerated() {
        //...
        //...
    }
}
```

## What I haven't finished yet
- TwitSplit application.
