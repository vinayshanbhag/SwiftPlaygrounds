//: Enumerations in Swift - Playground

import UIKit

// Enumeration defines a common type for a group of related values 
// and enables working with those values in a type-safe way.
// Raw values if provided can be String, Character, Integer, Float, Double.
// Associated values can be of any type.
//
// Syntax
enum CompassPoint { // Name is capitalized as this a new type and singular rather than plural
    case North
    case South
    case East
    case West
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

var direction:CompassPoint // direction is of type CompassPoint
direction = .East // shorter syntax as direction is known to be of type CompassPoint

let myPlanet = Planet.Earth

// Matching enumerations with switch
// Note: default is not required here as the switch is exhaustive
switch direction {
case .North: print("heading North")
case .South: print("heading South")
case .East: print("heading East")
case .West: print("heading West")
}

// Associated values
// Color is an enumeration type that takes
// a value of RGB with an associated value of type (Int, Int, Int) i.e. red, green and blue color components or
// a value of Hex with an associated value of type String
enum Color {
    case RGB(Int,Int,Int)
    case Hex(String)
}

var myColor:Color
myColor = .RGB(255, 0, 0)
//myColor = .Hex("FF0000")

// Matching enumerations with associated values in a switch
// Extract all values with a let or var
switch myColor {
case let .RGB(red, green, blue): print("red:\(red), green:\(green), blue:\(blue)")
case let .Hex(hexString): print("hexcolor:\(hexString)")
}

// Extract selective values with a let or var
switch myColor {
case .RGB(let red, _, _): print("red component:\(red)")
case .Hex(let hexString): print("hexcolor:\(hexString)")
}

// Enumerations with raw values
// Raw values may be of String, Character, Int, Float, Double types
enum ASCIIControlCharacter:Character { // raw type
    case Tab = "\t" //raw value must be assigned and of the declared type
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

var c = ASCIIControlCharacter.CarriageReturn
print("[\(c.rawValue)]")

// Implicitly assigned raw values.
// Applies to String and Int types only
enum Heading:String {
    case North, South, East, West // raw values are implicitly member names. i.e. "North","South","East" and "West"
}
Heading.North.rawValue

// In case of enum of Int type, first member is implicitly assigned a raw value of 0.
// If an integer value is assigned to the 1st member, rest of the members are implicitly assigned subsequent integer values
enum SolarSystem:Int {
    case Sun, Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

SolarSystem.Earth.rawValue

// Initialize enum from a raw value
// Initializer fails (returns nil) if there is no member corresponding to the raw value.
var anyPlanet:SolarSystem? //could be nil
anyPlanet = SolarSystem(rawValue: 3)
anyPlanet = SolarSystem(rawValue: 10) // nil here

// Recursive enumerations
// Use indirect keyword to indicate that the enum is recursive
indirect enum Tree<T:Comparable>: CustomStringConvertible {
    
    case Empty
    case Node(T, left: Tree, right: Tree)
    
    // Insert a new value in the tree
    func insert(newValue: T) -> Tree {
        switch self {
            
        case .Empty:
            return Tree.Node(newValue, left: Tree.Empty, right: Tree.Empty)
            
        case let .Node(value, left, right):
            if newValue > value {
                return Tree.Node(value, left: left, right: right.insert(newValue))
            } else {
                return Tree.Node(value, left: left.insert(newValue), right: right)
            }
        }
    }
    
    var depth: Int {
        switch self {
        case .Empty:
            return 0
        case let .Node(_, left, right):
            return 1 + max(left.depth, right.depth)
        }
    }
    
    var description: String {
        switch self {
        case .Empty:
            return ""
        case let .Node(value, left, right):
            return "\(left) \(value) \(right)" // Traverse inorder
        }
    }
}

var numberTree = Tree<Int>.Empty
numberTree
numberTree.depth

numberTree = numberTree.insert(10)
numberTree.depth

numberTree = numberTree.insert(7)
numberTree.depth

numberTree = numberTree.insert(21)
numberTree = numberTree.insert(9)
numberTree = numberTree.insert(14)
numberTree = numberTree.insert(19)
numberTree = numberTree.insert(3)
numberTree
numberTree.depth

var wordTree = Tree<String>.Empty
wordTree = wordTree.insert("now")
wordTree = wordTree.insert("is")
wordTree = wordTree.insert("the")
wordTree = wordTree.insert("time")
wordTree = wordTree.insert("for")
wordTree = wordTree.insert("all")
wordTree = wordTree.insert("good")
wordTree = wordTree.insert("men")
wordTree = wordTree.insert("to")
wordTree = wordTree.insert("come")
wordTree = wordTree.insert("the")
wordTree = wordTree.insert("aid")
wordTree = wordTree.insert("of")
wordTree = wordTree.insert("their")
wordTree = wordTree.insert("country")

wordTree.depth




