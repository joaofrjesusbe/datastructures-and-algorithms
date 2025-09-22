class Graph<Value>: CustomDebugStringConvertible where Value: Hashable & Comparable & CustomStringConvertible {
    private var adjacencyList: [Value: [Value]] = [:]
    private(set) var numberOfNodes: Int = 0

    func addVertex(_ value: Value) {
        if adjacencyList[value] == nil {
            adjacencyList[value] = []
            numberOfNodes += 1
        }
    }

    func addEdge(from: Value, to: Value) {
        // undirected graph
        guard from != to else { return }
        
        guard
            adjacencyList[from] != nil,
            adjacencyList[to] != nil
        else {
            return
        }
        
        adjacencyList[from]?.append(to)
        adjacencyList[to]?.append(from)
    }

    var debugDescription: String {
        var lines: [String] = []
        let allNodes = adjacencyList.keys.sorted()
        for node in allNodes {
            guard let connections = adjacencyList[node] else { continue }
            let joinedConnections = connections.sorted().map { $0.description }.joined(separator: " ")
            lines.append("\(node.description) --> \(joinedConnections)")
        }
        return lines.joined(separator: "\n")
    }
}


let graph = Graph<String>()
graph.addVertex("0")
graph.addVertex("1")
graph.addVertex("2")
graph.addVertex("3")
graph.addVertex("4")
graph.addVertex("5")
graph.addVertex("6")

graph.addEdge(from: "3", to: "1")
graph.addEdge(from: "3", to: "4")
graph.addEdge(from: "4", to: "2")
graph.addEdge(from: "4", to: "5")
graph.addEdge(from: "1", to: "2")
graph.addEdge(from: "1", to: "0")
graph.addEdge(from: "0", to: "2")
graph.addEdge(from: "6", to: "5")

print(graph.debugDescription)
