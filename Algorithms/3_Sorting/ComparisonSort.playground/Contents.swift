import UIKit

let numbers = [99, 44, 6, 2, 1, 5, 63, 87, 283, 4, 0]
var numbersToSort = numbers

// educational only. Not efficient
func bubbleSort<T>(array: inout [T]) where T: Comparable {
    for i in 0..<array.count {
        for j in 0..<array.count-1 {
            if array[j] > array[j+1] {
                let temp = array[j]
                array[j] = array[j+1]
                array[j+1] = temp
            }
        }
    }
}

bubbleSort(array: &numbersToSort)
print(numbersToSort)

// educational only. Not efficient
func selectionSort<T>(array: inout [T]) where T: Comparable {
    for i in 0..<array.count {
        var minIndex = i
        for j in i+1..<array.count {
            if array[j] < array[minIndex] {
                minIndex = j
            }
        }
        if minIndex != i {
            let temp = array[i]
            array[i] = array[minIndex]
            array[minIndex] = temp
        }
    }
}

numbersToSort = numbers
selectionSort(array: &numbersToSort)
print(numbersToSort)

// Use for few items and most sorted
func insertionSort<T>(array: inout [T]) where T: Comparable {
    for i in 1..<array.count {
        let key = array[i]
        var j = i - 1
        
        while j >= 0 && array[j] > key {
            array[j + 1] = array[j]
            j -= 1
        }
        
        array[j + 1] = key
    }
}

numbersToSort = numbers
insertionSort(array: &numbersToSort)
print(numbersToSort)

// worry about worst case. Carefull about space O(n)
func mergeSort<T>(array: inout [T]) where T: Comparable {
    
    guard array.count > 1 else { return }
    
    // Reused scratch buffer
    var temp = array
    
    func sort(_ lo: Int, _ hi: Int) {
        // Sort half-open range [lo, hi)
        if hi - lo <= 1 { return }
        let mid = (lo + hi) / 2
        sort(lo, mid)
        sort(mid, hi)
        merge(lo, mid, hi)
    }
    
    func merge(_ lo: Int, _ mid: Int, _ hi: Int) {
        var i = lo      // pointer in left half  [lo, mid)
        var j = mid     // pointer in right half [mid, hi)
        var k = lo      // write pointer in temp
        
        // Merge to temp (stable: <= keeps left first on ties)
        while i < mid && j < hi {
            if array[i] <= array[j] {
                temp[k] = array[i]; i += 1
            } else {
                temp[k] = array[j]; j += 1
            }
            k += 1
        }
        
        // Copy any remainder
        while i < mid { temp[k] = array[i]; i += 1; k += 1 }
        while j < hi  { temp[k] = array[j]; j += 1; k += 1 }
        
        // Copy merged segment back into the main array
        for idx in lo..<hi {
            array[idx] = temp[idx]
        }
    }
    
    sort(0, array.count)
}

numbersToSort = numbers
mergeSort(array: &numbersToSort)
print(numbersToSort)

// Best overall but bad choice of pivot can be worst O(n^2)
func quickSort<T>(array: inout [T]) where T: Comparable {
    guard array.count > 1 else { return }
    
    func partition(_ low: Int, _ high: Int) -> Int {
        let pivot = array[high]        // choose last element as pivot
        var i = low                    // place for swapping
        
        for j in low..<high {
            if array[j] <= pivot {
                array.swapAt(i, j)
                i += 1
            }
        }
        array.swapAt(i, high)
        return i
    }
    
    func sort(_ low: Int, _ high: Int) {
        if low < high {
            let p = partition(low, high)
            sort(low, p - 1)
            sort(p + 1, high)
        }
    }
    
    sort(0, array.count - 1)
}


numbersToSort = numbers
quickSort(array: &numbersToSort)
print(numbersToSort)
