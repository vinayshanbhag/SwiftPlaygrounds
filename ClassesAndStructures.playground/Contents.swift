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
// Lazy properties may appear in both reference(class) and value types (structures and enumerations)

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

enum SomeEnum{
   }






