//: Functions and Closures

import UIKit

// Definition
func greet(name:String)->String{
    return "Hello \(name)"
}

// Function Call
greet("John Appleseed")

// Parameter names
func greet(name:String, withGreeting:String) -> String {
    return "\(withGreeting) \(name)"
}
greet("John Appleseed", withGreeting: "Good morning")

// External parameter names
func greetAgain(name:String, withGreeting greeting:String) -> String {
    return "\(greeting) \(name)"
}
greetAgain("John Appleseed", withGreeting: "Good morning")

// Omitting external parameter names
func greetYetAgain(name:String, _ greeting:String) -> String {
    return "\(greeting) \(name)"
}
greetYetAgain("John Appleseed", "Good morning")

// Force external name for first parameter
func greetOneMoreTime(name name:String, greeting:String) -> String {
    return "\(greeting) \(name)"
}
greetOneMoreTime(name: "John Appleseed", greeting: "Good evening")

// External names may be identical. Bad practice.
func greeting(text name:String, text greeting:String) -> String {
    return "\(greeting) \(name)"
}
greeting(text: "John Appleseed", text: "G'day")

// Tuples as return types
func minMax(numbers:[Int])->(min:Int, max:Int) {
    var min = numbers[0]
    var max = numbers[0]
    for number in numbers {
        if min > number {
            min = number
        }
        if max < number {
            max = number
        }
    }
    
    return (min,max)
}
let bounds = minMax([4,9,20,42,23,7,32,5,21])
print("min:\(bounds.min), max:\(bounds.max)")

//Optional Tuples as return types
func minMax2(numbers:[Int])->(min:Int, max:Int)? { //optional tuple. Note: values in the tuple are not optional.
    var min:Int
    var max:Int
    
    guard !numbers.isEmpty else { // if array is empty return nil
        return nil
    }
    
    min = numbers[0]
    max = min
    for number in numbers {
        if min > number {
            min = number
        }
        if max < number {
            max = number
        }
    }
    
    return (min,max)
}

if let values = minMax2([]) {
    print("min:\(values.min), max:\(values.max)")
} else {
    print("Array is empty.")
}


// Functions with default values
func root(number:Double, n:Double = 2)->Double{
    return pow(number, 1/n)
}
root(2)
root(2,n: 3)

// Variadic parameters

// Function can have atmost 1 variadic parameter. 
// It can have other non-variadic parameters. 
// Variadic parameters can be placed at any position (i.e. need not be the last parameter)
func add(numbers:Double...)->Double{
    var sum:Double = 0
//    for number in numbers { // iterate an sum up numbers
//        sum += number
//    }
    sum = numbers.reduce(0, combine:{$0+$1}) // Internally numbers is an array. So the reduce function works as well.
    return sum
}

add(1,2,3,4,5,6,7,8)



// Variable and Constant parameters
// By default function parameters are constants. i.e.they cannot be modified within the function
// Use var to make them variable. Note: var makes a variable copy available inside the function.
// arguments are still passed by value and not by reference
func repeatMessage(message:String, var times:Int){
    while times > 0{
        print(message)
        times--
    }
}

var n = 4
repeatMessage("hello", times:n)
print(n) // Note: n is not modified

// In out parameters
// Use inout parameters for a function to have effect outside of scope its body
// This is not the same as returning values.
// inout parameters are implicitly variable and cannot be marked var or let
func swapIntegers(inout x x:Int, inout y:Int) {
    let temp = x
    x = y
    y = temp
}

// call swapIntegers
var x = 10 // must be vars
var y = 20 //
print("(x, y) : (\(x), \(y))")
swapIntegers(x:&x, y: &y)
print("(x, y) : (\(x), \(y))")




// Function Types
// Parameter types and return type define function type
func addIntegers(a:Int, b:Int)->Int {
    return a+b
}

var functype:(Int,Int)->Int // function types are also inferred. if addIntegers was assigned here, explicit type declaration would not be  required

functype = addIntegers
functype(2,3)

func multiplyIntegers(a:Int, b:Int)->Int{
    return a*b
}

functype = multiplyIntegers
functype(2,3)


// Function types as parameter types
func printFunction(function:(Int,Int)->Int, x:Int, y:Int){
    print("\(function(x,y))")
}

printFunction(multiplyIntegers, x: 4, y: 5)
printFunction(addIntegers, x: 4, y: 5)

// Function types as return types
func ftoc(f:Double)->Double {
    return (f-32)*5/9
}

func ctof(c:Double)->Double {
    return (c*9/5)+32
}

// Return either ftoc or ctof
func convert(fahrenheit:Bool)->(Double)->Double {
    return fahrenheit ? ftoc : ctof
}

var f = convert(true)
f(32)
var c = convert(false)
c(32)

// Nested functions
// Nested functions are hidden inside the enclosing function, but have closure over it.
func convertTemperature(fahrenheit:Bool)->(Double)->Double {
    func ftoc(f:Double)->Double {
        return (f-32)*5/9
    }
    
    func ctof(c:Double)->Double {
        return (c*9/5)+32
    }
    
    return fahrenheit ? ftoc : ctof
}

f = convertTemperature(true)
f(212)
c = convertTemperature(false)
c(100)


// Closures
// Closures take one of three forms:
// - Global functions are closures that have a name and do not capture any values.
// - Nested functions are closures that have a name and can capture values from their enclosing function.
// - Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.”

var fruits = ["Mango","Banana","Apple","Peach","Plum","Watermelon","Pineapple"]

// Array.sort takes a function (String,String)->Bool
func descending(s1:String, s2:String)->Bool {
    return s1 > s2
}

fruits.sort(descending)

// replace named function "descending" with a closure expression
var sorted = fruits.sort({(s1:String, s2:String)->Bool in return s1 > s2 })
sorted

// Parameter and return types are inferred from the function type Array.sort takes i.e. (String,String)->Bool
sorted = fruits.sort({(s1, s2) in return s1 > s2 })
sorted

// Single expression closures can implicitly return the expression and omit return keyword
sorted = fruits.sort({(s1, s2) in s1 > s2 })
sorted

// Replace arguments with shorthand argument names
sorted = fruits.sort({$0 > $1 })
sorted

// Trailing closure syntax. If a closure expression is the last parameter, then the closure expression may be written outside the parenthesis
sorted = fruits.sort(){$0 > $1 }
sorted

// Syntax when a closure is the only argument. The parenthesis may be dropped.
sorted = fruits.sort{$0 > $1 }
sorted

// String type has an overloaded > operator that compares 2 strings and returns a bool. i.e. function type (String, String)->Bool
// Pass the overloaded > operator as a function to sort
// Note: this syntax is very similar to fruits.sort(descending), just that an operator function is passed instead
sorted = fruits.sort(>)
sorted


// Closure capture
// Inner function incr() has closure over n and value variables in the enclosing function
func makeIncrementer(n:Int)->()->Int {
    var value = 0
    func incr()->Int{
        value += n
        return value
    }
    return incr
}

let incrementByTen = makeIncrementer(10)
incrementByTen()
incrementByTen()

let incrementByOne = makeIncrementer(1)
incrementByOne()
incrementByOne()

incrementByTen()

// Functions are reference types. anotherIncrementByTen and incrementByTen refer to the same.
var anotherIncrementByTen = incrementByTen
anotherIncrementByTen()

// now anotherIncrementByTen points to a new incrementer
anotherIncrementByTen = makeIncrementer(10)
anotherIncrementByTen()

