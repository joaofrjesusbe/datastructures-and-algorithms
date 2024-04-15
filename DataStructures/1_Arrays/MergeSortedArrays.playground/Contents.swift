// Merged sorted arrays
// Time: O(a + b)
// Space: O(a + b)
let arraySorted1 = [0, 3, 4, 31]
let arraySorted2 = [4, 6, 30]

func mergeSortedArrays(_ array1: [Int], _ array2: [Int]) -> [Int] {
    guard !array1.isEmpty else {
        return array2
    }
    guard !array2.isEmpty else {
        return array1
    }
    var merged = [Int]()
    let total = array1.count + array2.count
    var i = 0
    var j = 0
    while merged.count != total {
        if j >= array2.count || i < array1.count && array1[i] < array2[j] {
            merged.append(array1[i])
            i += 1
        } else {
            merged.append(array2[j])
            j += 1
        }
    }
    return merged
}

print(mergeSortedArrays(arraySorted1, arraySorted2))


// Merged sorted with unsorted arrays
// Time: O(a + log(a) + b + log(b)
// Space: O(a + b)
let array1 = [4, 3, 4, 343]
let array2 = [4, 0, 2, -3]

func mergeArrays(_ array1: [Int], _ array2: [Int]) -> [Int] {
    guard !array1.isEmpty else {
        return array2
    }
    guard !array2.isEmpty else {
        return array1
    }

    var array1 = array1
    array1.sort()

    var array2 = array2
    array2.sort()

    return mergeSortedArrays(array1, array2)
}

print(mergeArrays(array1, array2))
