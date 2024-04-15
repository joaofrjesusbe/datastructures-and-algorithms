// Factorial
func factorialRecursive(_ number: Int) -> Int {
    assert(number > 0, "Input must be > 0")
    guard number > 2 else {
        return number
    }

    return number * factorialRecursive(number - 1)
}

func factorialIterative(_ number: Int) -> Int {
    assert(number > 0, "Input must be > 0")
    guard number > 2 else {
        return number
    }

    var answer = 1
    for i in 2...number {
        answer = answer * i
    }
    return answer
}

let number = 5
print(factorialRecursive(number))
print(factorialIterative(number))


// Fibonacci

// O(2^N)
func fibonacciRecursive(_ n: Int) -> Int {
    assert(n >= 0, "Input must be > 0")

    if n < 2 {
        return n
    }

    return fibonacciRecursive(n - 1) + fibonacciRecursive(n - 2)
}

// O (n)
func fibonacciIterative(_ n: Int) -> Int {
    assert(n >= 0, "Input must be > 0")

    if n < 2 {
        return n
    }

    var cumm1 = 0
    var cumm2 = 1
    var total = 0

    for _ in 2...n {
        total = cumm1 + cumm2
        cumm1 = cumm2
        cumm2 = total
    }
    return total
}

let n = 10
print(fibonacciRecursive(n))
print(fibonacciIterative(n))

