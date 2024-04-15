
final class DoublyLinkedList<Value>: CustomDebugStringConvertible {
    final class Node: CustomDebugStringConvertible {
        var value: Value
        var next: Node?
        var previous: Node?

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
        node.previous = tail
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
        head?.previous = node
        head = node
        length += 1
        if length == 1 {
            tail = node
        }
    }

    private func node(at index: Int) -> Node? {
        guard (0..<length).contains(index) else { return  nil }
        var node: Node?
        if index <= length / 2 {
            node = head
            for _ in (0..<index) {
                node = node?.next
            }
        } else {
            node = tail
            let tailIndex = length - index - 1
            for _ in (0..<tailIndex) {
                node = node?.previous
            }
        }
        return node
    }

    @discardableResult
    func insert(_ value: Value, at index: Int) -> Value? {
        guard index != 0 else {
            prepend(value)
            return value
        }

        guard index != length else {
            append(value)
            return value
        }

        guard let leader = node(at: index - 1) else {
            return nil
        }

        let newNode = Node(value)
        let follower = leader.next

        leader.next = newNode
        newNode.next = follower
        newNode.previous = leader
        follower?.previous = newNode

        length += 1
        return value
    }

    @discardableResult
    func removeHead() -> Value? {
        guard head != nil else { return nil }
        let deleted = head
        head = deleted?.next
        head?.previous = nil
        length -= 1
        if length < 1 {
            tail = nil
        }
        return deleted?.value
    }

    @discardableResult
    func removeTail() -> Value? {
        remove(at: length)
    }

    @discardableResult
    func remove(at index: Int) -> Value? {
        guard index != 0 else { return removeHead() }
        guard let previous = node(at: index - 1) else { return nil }
        let deleted = previous.next
        let next = deleted?.next
        previous.next = next
        next?.previous = previous
        length -= 1
        if deleted === tail {
            tail = previous
        }
        return deleted?.value
    }

    var debugDescription: String {
        var nodefoward: Node? = head
        var arrayfoward = [String]()
        var nodeBackward: Node? = tail
        var arraybackward = [String]()

        while nodefoward != nil && nodeBackward != nil {
            arrayfoward.append(nodefoward!.debugDescription)
            nodefoward = nodefoward!.next
            arraybackward.append(nodeBackward!.debugDescription)
            nodeBackward = nodeBackward!.previous
        }
        return [
            "head -> \(arrayfoward.joined(separator: " -> ")) -> nil",
            "tail -> \(arraybackward.joined(separator: " -> ")) -> nil",
            "length: \(length)",
        ].joined(separator: "\n")
    }
}

let list = DoublyLinkedList<Int>()

list.insert(12, at: 0)
list.append(5)
list.append(16)
list.prepend(4)
list.insert(2, at: 4)
list.remove(at: 4)
/*
 list.insert(212, at: 0)
 list.remove(at: 0)
 list.insert(3, at: 5)
 list.remove(at: 4)
 */
print(list)
