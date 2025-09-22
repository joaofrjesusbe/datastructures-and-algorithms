class BinaryTree<T: Comparable>: CustomDebugStringConvertible {
    class Node {
        var value: T
        var left: Node?
        var right: Node?
        
        init(_ value: T) {
            self.value = value
        }
    }

    private var root: Node?

    @discardableResult
    func insert(_ value: T) -> Bool {
        if let root = root {
            return insert(from: root, value: value)
        } else {
            root = Node(value)
            return true
        }
    }

    private func insert(from node: Node, value: T) -> Bool {
        if value == node.value {
            return false
        } else if value < node.value {
            if let left = node.left {
                return insert(from: left, value: value)
            } else {
                node.left = Node(value)
                return true
            }
        } else {
            if let right = node.right {
                return insert(from: right, value: value)
            } else {
                node.right = Node(value)
                return true
            }
        }
    }

    func transverse(_ node: Node?) {
        guard let node = node else { return }
        transverse(node.left)
        print(node.value)
        transverse(node.right)
    }

    @discardableResult func remove(_ value: T) -> Bool {
        let (newRoot, removed) = remove(node: root, value: value)
        root = newRoot
        return removed
    }

    // Remove a value from the subtree rooted at `node`. Returns the new subtree root and whether a node was removed.
    private func remove(node: Node?, value: T) -> (Node?, Bool) {
        guard let node = node else { return (nil, false) }

        if value < node.value {
            let (newLeft, removed) = remove(node: node.left, value: value)
            node.left = newLeft
            return (node, removed)
        } else if value > node.value {
            let (newRight, removed) = remove(node: node.right, value: value)
            node.right = newRight
            return (node, removed)
        } else {
            // Found the node to delete
            // Case 1: No children
            if node.left == nil && node.right == nil {
                return (nil, true)
            }
            // Case 2: One child
            if node.left == nil { return (node.right, true) }
            if node.right == nil { return (node.left, true) }
            // Case 3: Two children — replace with inorder successor (minimum in right subtree)
            if let successor = minNode(from: node.right) {
                node.value = successor.value
                let (newRight, _) = remove(node: node.right, value: successor.value)
                node.right = newRight
                return (node, true)
            }
            // Fallback (shouldn’t reach here)
            return (node, false)
        }
    }

    // Find minimum node starting from a given subtree
    private func minNode(from node: Node?) -> Node? {
        var current = node
        while let next = current?.left { current = next }
        return current
    }

    var debugDescription: String {
        var result = ""
        func traverse(_ node: Node?, _ indent: String) {
            guard let node = node else { return }
            traverse(node.right, indent + "    ")
            result += indent + "\(node.value)\n"
            traverse(node.left, indent + "    ")
        }
        traverse(root, "")
        return result
    }
}

let tree = BinaryTree<Int>()
tree.insert(10)
tree.insert(20)
tree.insert(5)
tree.insert(15)
print(tree.debugDescription)
print("Removed 20?", tree.remove(20))
print(tree.debugDescription)
