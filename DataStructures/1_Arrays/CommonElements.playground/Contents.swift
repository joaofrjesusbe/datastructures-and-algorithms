// Q: Find the common element in arrays
let array1 = ["a", "b", "x", "c"]
let array2 = ["z", "x", "y"]

// R: Space eficiency
// Time: O(a + log(a) + b + log(b))
// Space: O(1)
func containsCommonItem1(_ arr1: [String], _ arr2: [String]) -> Bool {
    var arr1 = arr1
    arr1.sort()
    var arr2 = arr2
    arr2.sort()

    var i = 0
    var j = 0
    while i < arr1.count && j < arr2.count {
        if arr1[i] == arr2[j] {
            return true
        }
        if arr1[i] < arr2[j] {
            i += 1
        } else {
            j += 1
        }
    }

    return false
}

print(containsCommonItem1(array1, array2))

// R: Time eficiency
// Time: O(a + b)
// Space: O(b)
func containsCommonItem2(_ arr1: [String], _ arr2: [String]) -> Bool {
    let minArray = arr1.count <= arr2.count ? arr1 : arr2
    let maxArray = arr1.count > arr2.count ? arr1 : arr2

    var setValues = Set(minArray)
    for value in maxArray {
        if setValues.contains(value) {
            return true
        }
        setValues.insert(value)
    }

    return false
}

print(containsCommonItem2(array1, array2))

