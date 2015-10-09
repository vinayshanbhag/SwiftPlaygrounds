//: Swift Control flow

import UIKit

//for-in
//iterate over a closed range
for i in 1...5 {
    print(i, terminator: " ")
}
print("\n")
 
//iterate over a half open range
for i in 0..<5 {
    print(i,terminator: " ")
}

//ignore values in sequence
var count = 0
for _ in 1...5 {
    count++
}
count

print("\n")
//iterate over arrays
let fruitBasket = ["Mango", "Pineapple", "Guava", "Banana"]
for fruit in fruitBasket {
    print(fruit,terminator:" ")
}
print("\n")
//iterate over dictionary
let animalSounds = ["cat":"meow", "dog":"woof", "cow":"moo", "lion":"roar"]
for (animal, sound) in animalSounds {
    print("\(animal):\(sound)")
}

print("\n")
// for loop
for var i = 0; i < 5; i++ {
    print(i)
}
// print(i) // error. scope of i is limited to the for loop
print("\n")

// initialization and increment statements are optional
var condition = 0
for ;condition < 5; {
    condition++
}


// While loop
var index = 0
while index < 5 {
    print(index, terminator:" ")
    index++
}
print("")

// Repeat-while loop
var j = 0
repeat {
    print(j, terminator:" ")
} while j>0

print("")

// If else statements
var temperature = 85
if temperature > 80 { // must be a boolean expression
    print("it's warm - \(temperature)F")
} else if temperature > 55{
    print("it's pleasant - \(temperature)F")
} else {
    print("it's cold - \(temperature)F")
}

// Switch
let character:Character = "e"
switch character { // control expression can be of any type
    //case "a":
    //case "e": print("its a vowel") // error: no implicit fallthrough
    case "a","e","i","o","u": print("\(character) is a vowel")  //no implicit fallthrough. break is not required
    case "b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z":
        print("\(character) is a consonant")
    default: print("\(character) is neither a vowel nor a consonant") // switch statement must be exhaustive. All possible cases must be covered.
}

//explicit fallthrough
switch character {
    case "a": fallthrough  // explicit fallthrough
    case "e": print("its a vowel")
    default: print("\(character) is neither a vowel nor a consonant") // switch statement must be exhaustive. All possible cases must be covered.
}

//switch to match intervals
let number = 50
switch number {
    case 0: print("\(number) - none")
    case 1..<12: print("\(number) - a few")
    case 12: print("\(number) - a dozen")
    case 13..<24: print("\(number) - about a dozen")
    case 24..<100: print("\(number) - a few dozen")
    default: print("\(number) - too many")
}


// tuples in the control expression
let point:(Int,Int) = (0,1)
switch point {
case (0, 0): print("\(point) is at the origin")
case (_, 0): print("\(point) is on the X axis")
case (0, _): print("\(point) is on the Y axis")
default: print("point is at \(point)")
}

// value binding
let anotherPoint:(Int,Int) = (0,10)
switch anotherPoint {
case (0, 0): print("anotherPoint \(anotherPoint) is at the origin")
case (let x, 0): print("anotherPoint \(anotherPoint) is on the X axis at \(x)")
case (0, let y): print("anotherPoint \(anotherPoint) is on the Y axis at \(y)")
default: print("anotherPoint is at \(anotherPoint)")
}


// where clause
let yetAnotherPoint:(Int,Int) = (-10,-20)
switch yetAnotherPoint {
case (0, 0): print("\(anotherPoint) is at the origin")
case let(x, y) where x > 0 && y > 0 : print("yetAnotherPoint \(yetAnotherPoint) is in the first quadrant")
case let(x, y) where x < 0 && y > 0 : print("yetAnotherPoint \(yetAnotherPoint) is in the second quadrant")
case let(x, y) where x < 0 && y < 0 : print("yetAnotherPoint \(yetAnotherPoint) is in the third quadrant")
case let(x, y) where x > 0 && y < 0 : print("yetAnotherPoint \(yetAnotherPoint) is in the fourth quadrant")
default : print("yetAnotherPoint is on one of the axes")
}


// Guard statements
func greet(person:[String:String]){
    guard let name = person["name"] else {
        print("bye")
        return // Must exit the code block guard appears in. e.g. return,break,continue,throw or a function that does not return such as fatalError()
    }
    // values assigned using optional binding are available here
    print("Hello \(name)")
}

greet(["name":"John Appleseed"])
greet([:])


// API availability check
if #available(iOS 10, OSX 10.10, *) {
    print("available")
} else {
    print("not available")
}