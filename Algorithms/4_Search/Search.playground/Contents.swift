class BinaryTree<T: Comparable>: CustomDebugStringConvertible {
    class Node {
        var value: T
        var left: Node?
        var right: Node?
        
        init(_ value: T) {
            self.value = value
        }
    }

    private(set) var root: Node?

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
    
    func breadthFirstSearch() -> [T] {
        guard var currentNode = root else { return [] }
        var list: [T] = []
        var queue: [Node] = [currentNode]
        
        while queue.count > 0 {
            currentNode = queue.removeFirst()
            list.append(currentNode.value)
            if let leftNode = currentNode.left {
                queue.append(leftNode)
            }
            if let rightNode = currentNode.right {
                queue.append(rightNode)
            }
        }
        return list
    }
    
    func breadthFirstSearchRecursive() -> [T] {
        guard let root = root else { return [] }
        var queue = [root]
        var list: [T] = []
        return breadthFirstSearchRecursive(queue: &queue, list: &list)
    }
    
    func breadthFirstSearchRecursive(queue: inout [Node], list: inout [T]) -> [T] {
        guard !queue.isEmpty else {
            return list
        }
        
        let currentNode = queue.removeFirst()
        list.append(currentNode.value)
        if let leftNode = currentNode.left {
            queue.append(leftNode)
        }
        if let rightNode = currentNode.right {
            queue.append(rightNode)
        }
        return breadthFirstSearchRecursive(queue: &queue, list: &list)
    }
    
    func dfsInOrder() -> [T] {
        guard let root = root else { return [] }
        var list: [T] = []
        traverseInOrder(node: root, list: &list)
        return list
    }
    
    private func traverseInOrder(node: Node, list: inout [T]) {
        if let leftNode = node.left {
            traverseInOrder(node: leftNode, list: &list)
        }
        list.append(node.value)
        if let rightNode = node.right {
            traverseInOrder(node: rightNode, list: &list)
        }
    }
    
    func dfsPostOrder() -> [T] {
        guard let root = root else { return [] }
        var list: [T] = []
        traversePostOrder(node: root, list: &list)
        return list
    }
    
    private func traversePostOrder(node: Node, list: inout [T]) {
        if let leftNode = node.left {
            traversePostOrder(node: leftNode, list: &list)
        }
        if let rightNode = node.right {
            traversePostOrder(node: rightNode, list: &list)
        }
        list.append(node.value)
    }
    
    func dfsPreOrder() -> [T] {
        guard let root = root else { return [] }
        var list: [T] = []
        traversePreOrder(node: root, list: &list)
        return list
    }
    
    private func traversePreOrder(node: Node, list: inout [T]) {
        list.append(node.value)
        if let leftNode = node.left {
            traversePreOrder(node: leftNode, list: &list)
        }
        if let rightNode = node.right {
            traversePreOrder(node: rightNode, list: &list)
        }
    }
}

let tree = BinaryTree<Int>()
tree.insert(9)
tree.insert(4)
tree.insert(20)
tree.insert(1)
tree.insert(6)
tree.insert(15)
tree.insert(170)

print(tree.debugDescription)

print("BFS")
print(tree.breadthFirstSearch())
print(tree.breadthFirstSearchRecursive())

print("DFS In Order")
print(tree.dfsInOrder())

print("DFS Post Order")
print(tree.dfsPostOrder())

print("DFS Pre Order")
print(tree.dfsPreOrder())
