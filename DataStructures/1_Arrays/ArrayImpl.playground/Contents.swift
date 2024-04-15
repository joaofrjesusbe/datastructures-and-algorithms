struct CustomArray<Value> {
    private(set) var length: Int = 0
    private var data: [Int: Value] = [:]

    init() {
    }

    func get(_ index: Int) -> Value? {
        guard (0..<length).contains(index) else { return nil }
        return data[index]
    }

    mutating func push(_ item: Value) {
        data[length] = item
        length += 1
    }

    @discardableResult
    mutating func pop() -> Value? {
        guard length > 0 else { return nil }
        let lastItem = data[length-1]
        length -= 1
        data[length] = nil
        return lastItem
    }

    @discardableResult
    mutating func delete(_ index: Int) -> Value? {
        guard (0..<length).contains(index) else { return nil }
        let lastItem = data[index]
        shift(index)
        return lastItem
    }

    mutating private func shift(_ index: Int) {
        for i in index..<length-1 {
            data[i] = data[i+1]
        }
        pop()
    }
}

extension CustomArray: CustomDebugStringConvertible {
    var debugDescription: String {
        "Array(length: \(length), data: \(data))"
    }
}

var array = CustomArray<String>()
array.push("a")
array.push("b")
array.push("c")
array.delete(1)
print(array.debugDescription)

