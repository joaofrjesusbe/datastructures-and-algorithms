struct Queue<Value>: CustomDebugStringConvertible {
    private var array1: [Value] = []
    private var array2: [Value] = []

    func peek() -> Value? {
        array2.last
    }

    @discardableResult
    mutating func dequeue() -> Value? {
        guard array2.isEmpty else {
            return array2.removeLast()
        }
        array2 = array1.reversed()
        array1 = []
        return array2.removeLast()
    }

    mutating func enqueue(_ value: Value) {
        guard array2.isEmpty else {
            array1.append(value)
            return
        }
        array2.append(value)
    }

    var debugDescription: String {
        let fullArray = array2.reversed() + array1
        return [
            "\(fullArray)",
            "length: \(fullArray.count)",
        ].joined(separator: "\n")
    }
}

var queue = Queue<String>()
queue.enqueue("A")
queue.enqueue("B")
queue.enqueue("C")
queue.dequeue()
queue.dequeue()
queue.dequeue()
queue.enqueue("D")
queue.enqueue("E")
print(queue)
