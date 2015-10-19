//: Playground - noun: a place where people can play

import UIKit

// arrays let vs var
let fibs = [0, 1, 1, 2, 3, 5]

var fibsMutable = [0, 1, 1, 2, 3, 5]

// append
fibsMutable.append(8)

// append range
fibsMutable.appendContentsOf([13, 21])

//arrays are passed by value
var x = [1, 2, 3]
var y = x
y.append(4)

// NSArray is immutable but a trick can mutate the array
let a = NSMutableArray(array: [1, 2, 4])
let b: NSArray = a

a.insertObject(4, atIndex: 2)
// this will alter b even though b is immutable
b

// map function to apply exact same function to every element and return tranformed elements

// non map application
var squared: [Int] = []
for fib in fibs{
    squared.append(fib * fib)
}
squared

// map application
let squared2 = fibs.map { (fib) -> Int in
    fib * fib
}

// sort and contains
struct Person{
    var name: String
    var age: Int
    init(_name: String, _age: Int){
        name = _name
        age = _age
    }
}

var people: [Person] = []
people.append(Person(_name: "A", _age: 15))
people.append(Person(_name: "B", _age: 16))
people.append(Person(_name: "C", _age: 17))
people.append(Person(_name: "D", _age: 18))
people.append(Person(_name: "E", _age: 19))
people.append(Person(_name: "F", _age: 20))
people.append(Person(_name: "G", _age: 21))
people.append(Person(_name: "H", _age: 22))
people.append(Person(_name: "I", _age: 23))

// sort function
let sortedPeople = people.sort { (a, b) -> Bool in
    a.age > b.age
}

// contains function
let underage = people.contains { (a) -> Bool in
    a.age < 18
}

// filter
let adultOnly = people.filter { (a) -> Bool in
    a.age > 18
}

// extension on sequence
extension SequenceType{
    func findElement(match: Generator.Element -> Bool) -> [Generator.Element]{
        var result: [Generator.Element] = []
        for element in self where match(element){
            result.append(element)
        }
        return result
    }
}

let adultPeople = people.findElement { (a) -> Bool in
    a.age > 21
}

// extension on accumulate
extension Array{
    func accumulate<U>(initial: U, combine: (U, Element) -> U) -> [U]{
        var running = initial
        return self.map{ next in
            running = combine(running, next)
            return running
        }
    }
}

[1, 2, 3, 4].accumulate(0) { (a, b) -> Int in
    return a+b
}


// filterExtension
extension Array{
    func filterNew(condition: Element -> Bool) -> [Element]{
        var result: [Element] = []
        for x in self where condition(x){
            result.append(x)
        }
        return result
    }
}

[1, 2, 4, 5].filterNew { (a) -> Bool in
    a % 2 == 0
}

// reduce extension
extension Array{
    func reduceNew<U>(initial: U, combine: (U, Element) -> U) -> U{
        var result = initial
        for x in self{
            result = combine(result, x)
        }
        return result
    }
}

[1, 2, 3, 4].reduceNew(0, combine: +)

// flatmap extension
extension Array{
    func flatmapNew<U>(transform: Element -> [U]) -> [U]{
        var result: [U] = []
        for x in self{
            result.appendContentsOf(transform(x))
        }
        return result
    }
}

let flatArray1 = [1, 2, 3, 4, 5]
let flatArray2 = [90, 91, 92, 94, 98]
let onFlatMap = flatArray1.flatmapNew { a in
    flatArray2.map({ b in
        (a, b)
    })
}

// slicing array range by subscripting
fibs[2..<fibs.endIndex]

// swift automatically bridges number to NSnumber
var intArray = [1,2,3]
let z: NSArray = intArray
z[0] is NSNumber

// dictionaries

// merging two dictionaries
extension Dictionary{
    mutating func merge<S: SequenceType where S.Generator.Element == (Key, Value)>(other: S){
        for (k,v) in other{
            self[k] = v
        }
    }
}

var dictionary1 = ["key1":"value1","key2":"value2","key3":"value3"]
var dictionary2 = ["key4":"value4","key5":"value5","key6":"value6"]
dictionary1.merge(dictionary2)
dictionary1
dictionary2

// dictionary initializer with key value pair extension
extension Dictionary{
    init<S: SequenceType where S.Generator.Element == (Key, Value) > (_ sequence: S){
        self = [:]
        self.merge(sequence)
    }
}

let defaultAlarms = flatArray2.map { (a) in
    ("Alarm \(a)",false)
}
defaultAlarms
let alarmsDictionary = Dictionary(defaultAlarms)

// generatortype
// counter generator
class ConstrantGenerator: GeneratorType{
    typealias Element = Int
    var i = 0
    func next() -> Element? {
        return ++i
    }
}

var g = ConstrantGenerator()
g.next()
g.next()

//fibonacci generator
class fibsGenerator: GeneratorType{
    var state = (0, 1)
    func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

var fibsG = fibsGenerator()
for _ in 0...10{
    print(fibsG.next())
}

// fibonacci number
func fibonacci(till: Int) -> [Int]{
    var result: [Int] = []
    for i in 0..<till{
        result.append(fibsInternal(i))
    }
    return result
}

func fibsInternal(num: Int) -> Int{
    if num == 0{
        return num
    }
    if num == 1{
        return num
    }
    return fibsInternal(num - 1) + fibsInternal(num - 2)
}

fibonacci(3)

class Queue{
    var right:[Int] = []
    var left: [Int] = []
    
    func enqueue(elem: Int){
        right.append(elem)
    }
    func dequeue() -> Int?{
        guard !(left.isEmpty && right.isEmpty) else{
            return nil
        }
        if left.isEmpty{
            left = right.reverse()
            right.removeAll(keepCapacity: true)
        }
        return left.removeLast()
    }
    func count() -> Int{
        return right.count + left.count
    }
}

let q = Queue()
for _ in [0...10]{
    q.enqueue(Int(arc4random_uniform(255)))
}
for (var i = 0; i < q.count(); i++){
    print(q.dequeue())
}