func memoize<Input: Hashable, Output>(_ function: @escaping (Input) -> Output) -> (Input) -> Output {
    // our item cache
    var storage = [Input: Output]()

    // send back a new closure that does our calculation
    return { input in
        if let cached = storage[input] {
            return cached
        }

        let result = function(input)
        storage[input] = result
        return result
    }
}

func recursiveMemoize<Input: Hashable, Output>(
    _ function: @escaping ((Input) -> Output, Input) -> Output
) -> (Input) -> Output {
    // our item cache
    var storage = [Input: Output]()
    var memo: ((Input) -> Output)!
    memo = { input in
        if let cached = storage[input] {
            return cached
        }
        let result = function(memo, input)
        storage[input] = result
        return result
    }
    return memo
}

func addTo80(_ n: Int) -> Int {
    print("slow")
    return n + 80
}

let memoizeAddTo80 = memoize(addTo80)
print("1: \(memoizeAddTo80(80))")
print("2: \(memoizeAddTo80(80))")


var slowCalculations = 0
var dpCalculations = 0

func fibonacci(_ number: Int) -> Int {
    assert(number >= 0, "Input must be > 0")
    slowCalculations += 1
    return number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
}

let memoizedFibonacci = recursiveMemoize { (fibonacci, number: Int) -> Int in
    assert(number >= 0, "Input must be > 0")
    dpCalculations += 1
    return number < 2 ? number : fibonacci(number - 1) + fibonacci(number - 2)
}

print("Slow fib: \(fibonacci(10))")
print("Slow calculations: \(slowCalculations)")
print("DP fib: \(memoizedFibonacci(10))")
print("DP calculations: \(dpCalculations)")
