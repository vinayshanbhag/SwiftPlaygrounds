//: Collections Playground

/* Array */

//Array of words
let words = ["now","is","the","time","for", "all","good","men","to","come","to","the","aid","of","their","country"]

print("\niterate with index:\n")
for var i = 0; i < words.count; i++ {
    print(words[i])
}

print("\niterate using enumerate function:\n")
for word in words.enumerate() {
    print("\(word.index) - \(word.element)")
}

print("\nsorted words:\n")
for word in words.sort() {
    print(word)
}

print("\nsorted words in descending order:\n")
for word in words.sort(>) {
    print(word)
}


// Using map function to transform elements in array
// mark all words that begin with an "a"
let mappedWords = words.map{$0.hasPrefix("a") ? "* \($0) *" : $0}
print(mappedWords)

// (mis)Using map function to flatten an array into a string
var message = ""
words.map{message += $0 + " "}
print(message)

// Using reduce function to flatten an array of strings
let reducedMessage = words.reduce("",combine:{ ($0 == "" ? $0 : $0 + " ") + $1 } )
print(reducedMessage)

/* Dictionary */

var myFruits = [1:"Apple",2:"Orange",3:"Banana",4:"Pomegranate",5:"Pineapple",6:"Jackfruit",7:"Mango",8:"Watermelon",9:"Apricot",10:"Peach"]

print("\niterate to retrieve values:\n")
for fruit in myFruits{
    print(fruit.1)
}

let sortedFruits = myFruits.sort{$0.1 < $1.1}
sortedFruits.reduce("", combine: {($0 == "" ? $0 : $0 + " ") + $1.1})


print("\niterate to retrieve values:\n")
for (_,fruit) in myFruits {
    print(fruit)
}
print("\nkeys sorted:\n")
for index in myFruits.keys.sort() {
    print(index)
}

print("\nsorted values:\n")
for fruit in myFruits.values.sort(>) {
    print(fruit)
}

print("\nvalues sorted by key:\n")
for index in myFruits.keys.sort() {
    print(myFruits[index]!)
}


print("\nlist keys,values unsorted:\n")
for fruit in myFruits {
    print(fruit)
}

print("\nlist keys,values sorted by values:\n")
let sortedByNames = myFruits.sort{$0.1 < $1.1}
for fruit in sortedByNames {
    print(fruit)
}

print("\nlist keys,values sorted by keys:\n")
let sortedByKeys = myFruits.sort { $0.0 < $1.0 }
for fruit in sortedByKeys {
    print(fruit.1)
}


/* Set */
//var cards = Set<Character>()
//cards.insert("♠︎")
var cards:Set<Character> = ["♠︎", "♣︎", "♥︎", "♦︎"]


for card in cards {
    print(card)
}



