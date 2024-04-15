struct HashTable<Value> {
    typealias Bucket = (String, Value)

    // Note: Used on purpose arrays instead of a linkedlist
    // Not efficient for deletion, or duplication keys
    private var data: [[Bucket]?]

    init(size: Int) {
        self.data = Array(repeating: nil, count: size)
    }

    private func hashed(_ key: String) -> Int {
        var hash = 0
        for char in key {
            hash = (hash + Int(char.asciiValue!)) % data.count
        }
        return hash
    }

    func get(_ key: String) -> Value? {
        let address = hashed(key)
        let currentBucket = data[address]
        if let bucket = currentBucket {
            for (k, v) in bucket {
                if k == key {
                    return v
                }
            }
        }
        return nil
    }

    mutating func set(_ key: String, _ value: Value) {
        let address = hashed(key)
        var array: [Bucket] = data[address] ?? []
        array.append(Bucket(key, value))
        data[address] = array
        print(data)
    }

    func keys() -> [String] {
        var keysArray: [String] = []
        for bucketArray in data {
            if let bucketArray = bucketArray {
                for bucket in bucketArray {
                    keysArray.append(bucket.0)
                }
            }
        }
        return keysArray
    }
}

var myHashTable = HashTable<Int>(size: 2)
myHashTable.set("grapes", 10000)
myHashTable.set("apples", 54)
myHashTable.set("oranges", 154)
print(myHashTable.get("apples") ?? "nil")
print(myHashTable.keys())
