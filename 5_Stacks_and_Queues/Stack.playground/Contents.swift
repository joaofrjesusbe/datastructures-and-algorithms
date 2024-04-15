final class Stack<Value>: CustomDebugStringConvertible {
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

  private var top: Node?
  private var bottom: Node?
  private(set) var length: Int = 0

  init() { }

  func peek() -> Value? {
    top?.value
  }

  @discardableResult
  func pop() -> Value? {
    guard length > 0 else { return nil }
    let popped = top
    top = popped?.next
    length -= 1
    if length < 1 {
      bottom = nil
    }
    return popped?.value
  }

  func push(_ value: Value) {
    let node = Node(value)
    node.next = top
    length += 1
    top = node
    if length == 1 {
      bottom = node
    }
  }

  var debugDescription: String {
      var node: Node? = top
      var array = [String]()
      while node != nil {
        array.append(node!.debugDescription)
        node = node!.next
      }
      return [
        "\(array.joined(separator: " -> ")) -> nil",
        "top: \(top?.debugDescription ?? "nil")",
        "bottom: \(bottom?.debugDescription ?? "nil")",
        "length: \(length)",
       ].joined(separator: "\n")
  }
}

let stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.pop()
print(stack)
