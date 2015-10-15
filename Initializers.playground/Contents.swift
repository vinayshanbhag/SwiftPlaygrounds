//: Initializers Playground

// Designated Initialisers are primary initializers for a class
// Designated Initializers must initialize all stored properties and 
// call super class (if there is one) designated initializer
// Convenience initializers are secondary initializers that simplify
// initialization
// Convenience initializers may call other convenience initializers in
// the same class. Convenience initializer must ultimately call designated initializer
// in the same class
// Designated initializers must call designated initializer in super class.
// Required Initializers must be overridden in the subclass
// Failable initializers (init?) return nil if initialization fails. e.g.
// initializing an Enum from a raw value may fail and return nil
// Implicitly unwrapped failable initializers (init!) work the same way as 
// failable initializers, but cause an assertion failure if initialization fails

// Two phase initialization
// Phase 1: Each stored property is assigned an initial value by the class that introduced it
// Phase 2: Each class has an opportunity to customize its stored properties before initialization 
// is considered complete
//
// Check 1: A designated initializer must ensure all properties introduced by its class are initialized before
// it delegates to the super class's designated initializer
// 
// Check 2: A designated initializer must delegate to its super class's designated initializer before assigning
// a value to any of the inherited properties
// 
// Check 3: A convenience initializer must delegate to another initializer before assigning any values to any
// property including those in the same class
//
// Check 4: Initializers cannot call any instance methods or properties or refer to self until phase 1 is complete

class SomeClass{
    var property1:String
    var property2:Int
    
    // Designated Initializer
    init(p1:String, p2:Int){
        self.property1 = p1
        self.property2 = p2
    }
    
    // Convenience Initializer
    convenience init(p:Int){
        // self.property2 = 10 // error: Fails Check 3 & 4
        self.init(p1: "\(p)",p2: p) // Calls a designated initializer
    }
    
    // Convenience Initializer
    convenience init(){
        self.init(p: 1) // Calls a convenience initializer
    }
    
    func sayHello(){
        print("hello")
    }
}

class SomeSubClass:SomeClass {
    var subProperty1: Int
    var subProperty2: Int
    
    init(p1: String, p2: Int, s1:Int, s2:Int) {
        self.subProperty1 = s1 // This initialization is required before call to super.init
        self.subProperty2 = s2 // as per Check 1
        
        // self.property1 = "Hello" // error: Access to self, inherited instance properties and
        // self.sayHello()          // instance methods is not allowed here as per Check 2
        
        super.init(p1: p1, p2: p2) // This is required as per Check 1
        
        self.property1 = "Hello" // self, inherited instance properties and methods are accessible after phase 1
        self.sayHello()
    }
}