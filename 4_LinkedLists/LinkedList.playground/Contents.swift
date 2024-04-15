
final class LinkedList<Value>: CustomDebugStringConvertible {
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

    private(set) var head: Node?
    private(set) var tail: Node?
    private(set) var length: Int = 0

    init() {
    }

    convenience init(_ value: Value) {
        self.init()
        append(value)
    }

    func append(_ value: Value) {
        let node = Node(value)
        tail?.next = node
        tail = node
        length += 1
        if length == 1 {
            head = node
        }
    }

    func prepend(_ value: Value) {
        let node = Node(value)
        node.next = head
        head = node
        length += 1
        if length == 1 {
            tail = node
        }
    }

    private func node(at index: Int) -> Node? {
        guard (0..<length).contains(index) else { return  nil }

        var node: Node? = head
        for _ in (0..<index) {
            node = node?.next
        }
        return node
    }

    @discardableResult
    func insert(_ value: Value, at index: Int) -> Value? {
        guard index != 0 else {
            prepend(value)
            return value
        }

        guard index != length - 1 else {
            append(value)
            return value
        }

        guard let node = node(at: index) else {
            return nil
        }

        let newNode = Node(value)
        newNode.next = node.next
        node.next = newNode
        length += 1
        return value
    }

    @discardableResult
    func removeHead() -> Value? {
        guard head != nil else { return nil }
        let deleted = head
        head = deleted?.next
        length -= 1
        if length < 1 {
            tail = nil
        }
        return deleted?.value
    }

    @discardableResult
    func removeTail() -> Value? {
        remove(at: length - 1)
    }

    @discardableResult
    func remove(at index: Int) -> Value? {
        guard index != 0 else { return removeHead() }
        guard let previous = node(at: index - 1) else { return nil }
        let deleted = previous.next
        previous.next = deleted?.next
        length -= 1
        if deleted === tail {
            tail = previous
        }
        return deleted?.value
    }

    var debugDescription: String {
        var node: Node? = head
        var array = [String]()
        while node != nil {
            array.append(node!.debugDescription)
            node = node!.next
        }
        return [
            "\(array.joined(separator: " -> ")) -> nil",
            "head: \(head?.debugDescription ?? "nil")",
            "tail: \(tail?.debugDescription ?? "nil")",
            "length: \(length)",
        ].joined(separator: "\n")
    }
}

let list = LinkedList<Int>()

list.insert(12, at: 0)
list.append(5)
list.append(16)
list.prepend(4)
list.insert(2, at: 3)
list.insert(212, at: 0)
list.remove(at: 0)
print(list)
