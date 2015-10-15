//: Classes and Structures playground

// Class syntax
class Person {
    // stored properties must be initialized -
    // either here or in an initializer
    var name:String
    var age:Int
    var address:String? // Optional properties (explicitly/implicitly unwrapped) are initialized to nil
    
    // initializer (constructor)
    // unlike structures, classes do not automatically get a memberwise initializer
    init(name:String, age:Int){
        self.name = name
        self.age = age
    }
    
}

var person = Person(name: "John Appleseed", age: 30)
// Properties are accessed with the dot syntax
print("Person- name:\(person.name), age:\(person.age)")

// Struct syntax
struct Point {
    var x:Int
    var y:Int
}

var point = Point(x: 10, y: 10) // memberwise initializer is automatically provided unless a custom initializer is defined
// Properties are accessed with the dot syntax
print("Point: (x,y) = (\(point.x),\(point.y))")

// Structures are value types
// A copy is created on assignment or when passed to a function
var newPoint = point // newPoint is a copy of point
newPoint.x = 20 // point is not affected by this change
print("newPoint(\(newPoint.x),\(newPoint.y)), point(\(point.x),\(point.y))")

/*  “copying” of value types is optimized by Swift. Although the behavior in your code will always be as if a copy took place, an actual copy is performed behind the scenes only when it is absolutely necessary to do so. Do not avoid assignment.
*/

// structure constants are immutable even if the structure members are variables
let anotherPoint = Point(x: 5, y: 5)
//anotherPoint.x = 6 // error

// Classes are reference types
// Reference types are not copied when assigned or passed to a function
// A reference to an existing instance is used instead
var anotherPerson = person // refer to the same instance
print("person- name:\(person.name), age:\(person.age)")
anotherPerson.age = 35 // changes person.age as both refer to the same instance
print("person- name:\(person.name), age:\(person.age)")

// Constant reference to a class instance can mutate the instance
let yetAnotherPerson = anotherPerson
yetAnotherPerson.age = 25 // this is allowed as classes are reference types
// yetAnotherPerson = person // error: yetAnotherPerson is a constant

// Identity Operators for reference types
// Use === to check if two constants or variables refer to the same instance
// Use !== to check if two constants or variables do not refer to the same instance
anotherPerson === person
anotherPerson = Person(name: "John Appleseed", age: 35)
anotherPerson === person


// Stored properties
// All structure and class properties in examples above are stored properties


// Lazy stored properties
// Properties whose initial values are not computed until the first time they are used
// This is unlike other stored properties which are initialized when a class instance is created

// Document is a class with two stored properties
// - metadata is a stored property
// - exporter is a lazy stored property
class Document {
    var metadata:DocumentMetadata
    lazy var exporter:FileExporter = FileExporter()
    init(){
        metadata = DocumentMetadata(title: "filename")
        print("Document initialized")
    }
    
    func save(){
        print("save called")
        exporter.export(self)
    }
}

// FileExporter
class FileExporter {
    init(){
        print("FileExporter initialized")
    }
    
    func export(doc:Document){
        print("export called")
    }
}

class DocumentMetadata {
    var title:String
    init (title:String){
        print("DocumentMetadata initialized")
        self.title = title
    }
}


var myDocument = Document() // lazy property exporter is not initialized here
myDocument.save() // lazy property exporter is initialized when exporter is first accessed

// Lazy properties must be variables (var)
// Lazy properties cannot have observers (didSet, willSet)
// Lazy properties may be of any type
// Lazy properties may appear in classes and structures, but not enumerations. As enumerations cannot have stored properties
// Only stored properties may be lazy. Computed properties cannot be lazy
// Lazy properties if accessed from multiple threads, may be initialized more than once

// Stored Properties and Instance Variables
// Swift unifies both these concepts into a single property declaration

// Computed Properties
// Do not store a value
// Provide a getter and an optional setter to get/retrieve values
struct Temperature {
    var celcius:Double = 30
    var fahrenheit:Double { // computed property
        get{
            return (celcius * 9 / 5) + 32
        }
        set{ // setter (optional) makes this a read write computed property
            celcius = (newValue - 32)*5/9 // newValue is the implicit parameter name
        }
    }
}

var t = Temperature(celcius: 30)
t.celcius
t.fahrenheit
t.fahrenheit = 32
t.celcius


//Read-only computed property
struct Coodinate {
    var x: Int
    var y: Int
    var quadrant: Int? { // read-only property returns the quadrant that the point lies in, or nil if it is on one of the axes
        
        // "get {" syntax may be omitted since it is read-only property
        switch (self.x, self.y){
            case let(x, y) where x > 0 && y > 0 : return 1
            case let(x, y) where x < 0 && y > 0 : return 2
            case let(x, y) where x < 0 && y < 0 : return 3
            case let(x, y) where x > 0 && y < 0 : return 4
            default : return nil
        }
    }
}
var coord = Coodinate(x: -1, y: 1)
coord.quadrant

// Property Observers
// Respond to changes in property's value
// willSet is called before a property value is changed
// didSet is called after a property value is changed
// Either willSet or didSet, or both may be implemented
// Propery observers are not called when a (non-overridden) property is initialized (inplace or in an initializer)
// Property observers are not called for any changes made to the property within its observer
// Lazy stored properties cannot have property observers
// Property Observers can be created for overridden properties either stored or computed
// Property observers of a superclasses properties are called when a property is set in a subclass initializer
// non-overridden computed properties cannot have property observers
//
struct Counter {
    var count = 0 {
        willSet{
            print("count will be set to \(newValue) from \(count)")
        }
        didSet {
            print("count was set to \(count) from \(oldValue)")
        }
    }
}
var counter = Counter()
counter.count = 10


// Type properties
// Associated with a type and not an instance
// defined with the static keyword
// Use class keyword instead of static in case of computed type properties of a class, so that 
// they may be overridden in a subclass
// Type properties may be stored or computed
// All stored type properties are lazily instantiated upon first access, without an explicit lazy declaration
// Stored type properties are guaranteed to be initialized exactly once, even if accessed from multiple threads
// Stored type properties support property observers (willSet, didSet)
// Computed type properties have get method and optionally a set method if not read-only
// Static properties are not supported in generic types. Class properties are supported with generic types
enum SomeEnum{
    case a, b, c
    
    // var storedProperty = 0 //error: not allowed in enums
    var computedProperty:Int{
        get{ // optional if read-only
            switch self{
            case .a: return 1
            case .b: return 2
            case .c: return 3
            }
        }
        
        set {
            switch newValue {
            case 1: self = .a
            case 2: self = .b
            case 3: self = .c
            default: self = .a
            }
        }
    }
    
    // stored type property
    static var storedTypeProperty = "SomeEnumWithTypeProperty"
    
    // computed type property
    static var computedTypeProperty:String {
        get{
            return "I am \(storedTypeProperty)"
        }
        set {
            storedTypeProperty = newValue
        }
    }
}

var someEnum = SomeEnum.a // new instance with value .a
someEnum.computedProperty // 1
someEnum.computedProperty = 2 // set computed propert to 2. enum value to .b
someEnum // now has value .b

SomeEnum.storedTypeProperty
SomeEnum.computedTypeProperty
SomeEnum.computedTypeProperty = "...Anonymous"
SomeEnum.computedTypeProperty

struct SomeStruct {
    

    var storedProperty = 0
    var computedProperty:Int{
        get { // can be omitted if read-only
            return storedProperty * 2
        }
        set {
            storedProperty = newValue/2
        }
    }
    
    // stored type property
    static var storedTypeProperty = "SomeEnumWithTypeProperty"
    
    // computed type property
    static var computedTypeProperty:String {
        get{
            return "I am a \(storedTypeProperty)"
        }
    }
}

class SomeClass {
    var storedProperty = 0
    var computedProperty:Int{
        get { // can be omitted if read-only
            return storedProperty * 2
        }
        set {
            storedProperty = newValue/2
        }
    }
    
    // stored type property
    static var storedTypeProperty = "SomeEnumWithTypeProperty"
    
    // computed type property
    static var computedTypeProperty:String {
        get{
            return "I am a \(storedTypeProperty)"
        }
    }
    
    class var overridableComputedTypeProperty:Int {
        return 1
    }
}

class SubclassOfSomeClass:SomeClass {
    // static to prevent further override
    override static var overridableComputedTypeProperty:Int {
        return 2
    }
}

SomeClass.overridableComputedTypeProperty
SubclassOfSomeClass.overridableComputedTypeProperty


// Methods
// Functions associated with a particular type
// Classes, Structures and Enumerations can define instance methods and type methods
// Instance methods belong to an instance of the type
// Type methods belong to the type
// Instance methods must be declared mutating, if they modify state of a value type
// Instance methods of reference type are implicitly mutating
// Constants refering to a value type are immutable. i.e. cannot mutate or call a mutating function
// Type methods cannot access instance properties or methods
// Type methods are declared using static keyword. Use class keyword to enable overriding of a class method in its subclass
// Type methods are supported with generic types


// Syntax
class BeanCounter {
    var beanCount = 0
    
    // Instance method
    func increment() -> Int{
        return ++beanCount
    }
    func decrement() -> Int{
        return --beanCount
    }
}

let myBeans = BeanCounter()
for _ in 1...10{
    myBeans.increment() // reference type can be mutated eventhough myBeans is a constant
}
myBeans.beanCount

// Syntax value type - Structure
struct Position{
    var x:Int
    var y:Int
    
    mutating func moveBy(dx dx:Int = 0, dy:Int = 0){
        x += dx
        y += dy
    }
    
    // mutate self
    mutating func moveTo(x x:Int, y:Int){
        self = Position(x: x, y: y)
    }
}

var pos1 = Position(x: 0,y: 0)
pos1.moveBy(dx: 10,dy: 10)
pos1.moveTo(x: 100, y: 100)

let pos2 = Position(x: 0,y: 0)
// pos2.moveBy(dx: 10,dy: 10) //error: cannot be mutated since pos2 is a constant
// pos2.moveTo(x: 100, y: 100) //error: cannot be mutated since pos2 is a constant

// Syntax with value type - Enumeration
enum TrafficLight {
    case Red, Amber, Green
    mutating func next(){
        switch self {
        case .Red: self = .Green
        case .Amber: self = .Red
        case .Green: self = .Amber
        }
    }
}
var trafficLight = TrafficLight.Red
trafficLight
trafficLight.next()
trafficLight.next()
trafficLight.next()
trafficLight.next()

// Type Methods
// Methods associated with a type. 
// Type methods cannot access instance properties or methods
// Type methods are declared using static keyword. 
// Use class keyword to enable overriding of a class method in its subclass
// Type methods are supported with generic types




// Subscripts
// Shortcuts to access members in a collection.
// Classes, Structure and Enumerations can define subscripts
// Subscripts can be overloaded
// Subscripts can be multi-dimensional

// Syntax
struct TimesTable {
    let multiplier:Int
    
    subscript(index:Int) -> Int {
        return index * multiplier
    }
}

let threeTimesTable = TimesTable(multiplier: 3)

print("6 x 3 = \(threeTimesTable[6])")

struct FizzBuzz {
    subscript (index:Int)->String{
        if index % 15 == 0{
            return "fizzbuzz"
        }
        if index % 3 == 0{
            return "fizz"
        }
        if index % 5 == 0{
            return "buzz"
        }
        return ""
    }
}

let fizzbuzz = FizzBuzz()
for i in 1...100 {
    print("\(i):\(fizzbuzz[i])")
}














