final class Queue<Value>: CustomDebugStringConvertible where Value: CustomStringConvertible {
    final class Node: CustomDebugStringConvertible {
        var value: Value
        var next: Node? = nil

        init(_ value: Value) {
            self.value = value
        }

        var debugDescription: String {
            String(describing: value)
        }
    }

    private var first: Node?
    private var last: Node?
    private(set) var length: Int = 0

    init() { }

    func peek() -> Value? {
        first?.value
    }

    @discardableResult
    func dequeue() -> Value? {
        guard length > 0 else { return nil }
        let popped = first
        first = first?.next
        length -= 1
        if length < 1 {
            last = nil
        }
        return popped?.value
    }

    func enqueue(_ value: Value) {
        let node = Node(value)
        last?.next = node
        length += 1
        last = node
        if length == 1 {
            first = node
        }
    }

    var debugDescription: String {
        var node: Node? = first
        var array = [String]()
        while node != nil {
            array.append(node!.debugDescription)
            node = node!.next
        }
        return [
            "\(array.joined(separator: " -> ")) -> nil",
            "first: \(first?.debugDescription ?? "nil")",
            "last: \(last?.debugDescription ?? "nil")",
            "length: \(length)",
        ].joined(separator: "\n")
    }
}

let queue = Queue<String>()
queue.enqueue("A")
queue.enqueue("B")
queue.dequeue()
print(queue)
