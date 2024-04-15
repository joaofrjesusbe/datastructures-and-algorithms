// Reversed an array without using reversed
// Time: O(n)
// Space: O(n)
var array = [1, 4, 6, 54, 8, 0, 20]

func customReversed<Value>(array: [Value]) -> [Value] {
    var backwards = [Value]()
    for i in 1...array.count {
        let index = array.count - i
        backwards.append(array[index])
    }
    
    return backwards
}

print(customReversed(array: array))


// Reversed a string without using reversed
// Time: O(n)
// Space: O(n)
var greeting = "Hello, playground 😊"

func customReversed(string: String) -> String {
    var backwards = [String.Element]()
    var index = string.endIndex
    for _ in 0..<string.count {
        index = string.index(before: index)
        backwards.append(string[index])
    }
    
    return String(backwards)
}

print(customReversed(string: greeting))
