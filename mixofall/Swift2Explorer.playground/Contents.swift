//: Playground - noun: a place where people can play

import UIKit

// print on console
print("Hola! como esta!")

// let to make constant
let colorValue = UIColor.redColor()

// var to create variables
var message = "Hello this is a message"
print(message)

// explicit type definition for a variable
var constant:Float = 4

// explicit conversaion for type by casting
var str = "This is a string "
var width = 94
print(str + String(width))

// convert object to string with object
print("sample message \(54)")

// creating array
var shoppingList = ["catfish", "water", "tulips", "blue paint"]

// updaing value in array
shoppingList[1] = "coffee"
print(shoppingList)

//creating dictionary
var occupations = ["Malcom":"Captain", "Kaylee":"Mechanic"]
occupations["Malcom"] = "Engineer"
print(occupations)

// empty array
shoppingList = []

// empty dictionary
occupations = [:]

// for in example
let scores = [98,89,11,34,56]

for score in scores{
    if score > 50{
        print("Good Job")
    }else{
        print("No worries, better luck next time")
    }
}

// use let to unwrap optional value
var someOptionValue: String? = "Hola"

if let val = someOptionValue{
    print(val)
}

// switch statement
let veggi = "Red Pepper"
switch veggi{
    case "celery":
        print("celery added")
    case "cucumber", "watercress":
        print("cucumber or watercress")
    
    // let can be used in switch as well as below
    case let x where x.hasSuffix("Pepper"):
        print("Its a pepper")
    default:
        print("everything else will fall here")
}

// for in loop over dictionary
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25]
]

var largest = 0
var kindOfNumber: String?
for (kind, numbers) in interestingNumbers{
    for number in numbers{
        if number > largest{
            largest = number
            kindOfNumber = kind
        }
    }
}

print(largest)
print(kindOfNumber!)

// while loop
var n = 2
while n < 100{
    n = n * 2
}
print(n)

// do while is repeat while in swift
var m = 3
repeat{
    m = m * 3
}while m < 3

print(m)

//using range for looping
var firstForLoop = 0
for i in 0..<4{
    firstForLoop += i
}
print(firstForLoop)

// functions
func greetings(name: String, message: String) -> String{
    return "Hello \(name), your message is: \(message)"
}

print(greetings("Anoop", message: "Where are you OB1?"))

// tuples use
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, avg: Int){
    var mi = scores[0]
    var ma = 0
    var av = 0
    for score in scores{
        switch score{
        case let sc where score < mi:
            mi = sc
        case let sc where score > ma:
            ma = sc
        default: break
        }
        av += score
    }
    
    return (min: mi, max: ma, avg: av/scores.count)
}

var calculations = calculateStatistics([12, 44, 77, 55, 89, 1])
calculations.min
calculations.max
calculations.avg

// list of same arguments in a function
func sum(num: Int...) -> Int{
    var sum = 0
    for n in num{
        sum += n
    }
    return sum
}

sum(12,334,45,66)

// avg using list of arguments
func avg(number: Int...) -> Int{
    var avg = 0
    for n in number{
        avg += n
    }
    return avg / number.count
}

avg(1,2,3,4,5,6)

// nested function

func febonacciNumber(num: Int) -> [Int]{
    
    var result = [Int]()
    
    
    func febInternal(n: Int) -> Int{
        if n == 0{
            return 0
        }
        if n == 1 || n == 2{
            return 1
        }
        return febInternal(n - 1) + febInternal(n - 2)
    }
    
    
    for i in 0...num{
        result.append(febInternal(i))
    }
    
    return result
}

febonacciNumber(8)

// function can return another function
func makeIncrementer() -> (Int -> Int){

    func addOne(number: Int) -> Int{
        return number + 1
    }
    return addOne
}

var increment = makeIncrementer()
increment(10)

// function take one argument return function with two argument
func someRandomFunction(n: Int)-> (Int, Int) -> Int{
    func anotherFunc(a: Int, b: Int) -> Int{
        return (a + b) * n
    }
    return anotherFunc
}

var calcRandomFunction = someRandomFunction(2)
calcRandomFunction(12, 13)

// pass function as param argument
func passFuncAsParam(list: [Int], condition: (Int) -> Bool) -> [Int]{
    var filtered = [Int]()
    for l in list{
        if condition(l){
            filtered.append(l)
        }
    }
    return filtered
}

passFuncAsParam([12,32,334,55,221,4,13,4,56]) { (value) -> Bool in
    if value % 2 == 0{
        return true
    }
    return false
}

passFuncAsParam([12,23,12,33,33]) { (value) -> Bool in
    return value > 21
}

// map closure
[122,2,34,5,6,2,5,1].map({
    (value) -> Int in
    // return result
    //return value % 2 == 0 ? value : 0
    // closure will return last statement anyways so above can be written as
    value % 2 == 0 ? value : 0
})

// refer closure params by number 
let sorted = [122,2,34,5,6,2,5,1].sort({$0 > $1})
print(sorted)

// class
class Shape{
    var numberOfSides = 0
    var name: String
    
    init(name: String){
        self.name = name
    }
    func simpleDescription() -> String{
        return "A shape with \(numberOfSides) sides is called \(name)"
    }
}

var shape = Shape(name: "Triangle")
shape.numberOfSides = 3
shape.simpleDescription()

// subclass
class Square: Shape{
    var sideLength: Double
    
    init(name:String, sideLength: Double){
        self.sideLength = sideLength
        super.init(name: name)
        self.name = name
        self.numberOfSides = 4
    }
    
    func area() -> Double{
        return self.sideLength * self.sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with area \(area())"
    }
}

var test = Square(name: "Square", sideLength: 4)
test.simpleDescription()

// subclass 2 
class Circle: Shape{
    var radius: Double
    
    init(name: String, radius: Double) {
        self.radius = radius
        super.init(name: name)
        self.name = name
    }
    func area() -> Double{
        return M_PI * (self.radius * self.radius)
    }
    override func simpleDescription() -> String {
        return "Circle with radius \(radius) and area \(area())"
    }
}

var circleTest = Circle(name: "Circle", radius: 12)
circleTest.simpleDescription()

// getter setter
class EquilateralTriangle: Shape{

    var sideLength: Double = 0.0
    
    init(parimeter: Double,name: String) {
        super.init(name: name)
        self.Perimeter = parimeter
    }
    
    var Perimeter: Double{
        get{
            return 3 * sideLength
        }set{
            sideLength = newValue / 3
        }
    }
    
    override func simpleDescription() -> String {
        return "Equilateral triangle's side length is \(sideLength) for perimeter \(Perimeter)"
    }
}

var eqTest = EquilateralTriangle(parimeter: 9.9, name: "Triangle")
eqTest.simpleDescription()

// didset and willset
class TriangleAndSquare{
    var triangle: EquilateralTriangle{
        willSet{
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square{
        willSet{
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(name: String, sideLength: Double){
        triangle = EquilateralTriangle(parimeter: sideLength * 3, name: name)
        square = Square(name: name, sideLength: sideLength)
    }
    
    func simpleDescription() -> String{
        return "Triangle side is: \(triangle.sideLength) and Square side is \(square.sideLength)"
    }
}

var tasTest = TriangleAndSquare(name: "test", sideLength: 12)
tasTest.simpleDescription()
tasTest.square.sideLength = 5
tasTest.simpleDescription()
tasTest.square = Square(name: "newSquare", sideLength: 50)
tasTest.simpleDescription()

// having ? before operations like methods, properties, subscripting will do automatic check for nil. If the value is nil everything after ? will be ignored and returned as nil but if value exists then value will be treated unwrapped after that. Both cases will return optional value

let optionalSquare: Square? = Square(name: "optionalSquare", sideLength: 2.8)
optionalSquare?.simpleDescription()
optionalSquare?.sideLength

// enums
enum Rank: Int{
    // value to enum's member is incremental that's why on first one is assigned a value and rest will take incremental value
    // values can be string or floating point numbers
    case Ace = 1
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King
    // enums can have functions but not stored properties
    func simpleDescription() -> String{
        switch self{
            case .Ace: return "Ace"
            case .Jack: return "Jack"
            case .King: return "King"
            case .Queen: return "Queen"
            default: return "\(self.rawValue)"
        }
    }
    
    static func compare(a: Rank, b:Rank) -> Bool{
        return a.rawValue == b.rawValue
    }
}

let ace = Rank.Ace
ace.simpleDescription()
let ten = Rank.Ten
ten.simpleDescription()
let secondAce = Rank.Ace

Rank.compare(ace, b: ten)
Rank.compare(ace, b: secondAce)

// raw value member will only be present for enum member that have raw value assigned to it
secondAce.rawValue

// convert number to Rank enum value
let convertRank = Rank(rawValue: 1)

// enum without initial value
enum Suit: Int{
    case Spades = 1
    case Hearts, Diamonds, Clubs
    func simpleDescription() -> String{
        switch self{
        case .Spades: return "Spades"
        case .Hearts: return "Hearts"
        case .Diamonds: return "Diamonds"
        case .Clubs: return "Clubs"
        }
    }
    func icon() -> String{
        switch self{
        case .Spades: return "♠️"
        case .Hearts: return "❤️"
        case .Diamonds: return "♦️"
        case .Clubs: return "♣️"
        }
    }
}

let suite = Suit.Hearts
suite.icon()

// structure
struct Card{
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String{
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
}

let threeOfSpades = Card(rank: .Three, suit: .Spades)
threeOfSpades.simpleDescription()


// struct is pass by value vs classes are passed by reference
var copyOfStruct = threeOfSpades
copyOfStruct.rank = Rank.King
copyOfStruct.simpleDescription()

// enum with params
enum ServerResponse{
    case Result(String, String)
    case Error(String)
}

func evalResponse(response: ServerResponse) -> String{
    switch response{
    case let .Result(sunrise, sunset):
        return "Sunrise at \(sunrise) and sunset at \(sunset)"
    case let .Error(error):
        return "Error: \(error)"
    }
}

let successResponse = ServerResponse.Result("3.30am", "4.4pm")
let errorResponse = ServerResponse.Error("Well, sun is still sleeping.")

evalResponse(successResponse)
evalResponse(errorResponse)

// enum with param call
enum operations{
    case add(Int, Int)
    case increment(Int)
}

func calculator(operation: operations) -> Int{

    switch operation{
    case let .add(a, b): return a+b
    case var .increment(a): return ++a
    }
}

let addition = calculator(operations.add(12, 12))
let inc = calculator(operations.increment(14))

// use of protocol 

protocol exampleProtocol{
    var simpleDescription: String { get }
    mutating func adjust()
}

class simpleClass: exampleProtocol{
    var simpleDescription: String = "Simple class"
    func adjust() {
        simpleDescription += " with new adjustment."
    }
}

struct simpleStruct: exampleProtocol {
    var simpleDescription: String = "Simple struct"
    mutating func adjust() {
        simpleDescription += " new developments are in place."
    }
}

enum simpleEnum: exampleProtocol{
    case base, adjusted
    
    var simpleDescription: String{
        get {
            return self.getDescription()
        }
    }
    
    func getDescription() -> String{
        switch self{
        case .base: return "simple enum"
        case .adjusted: return "adjusted enum"
        }
    }
    
    mutating func adjust() {
        self = simpleEnum.adjusted
    }
}

var c = simpleClass()
var s = simpleStruct()
var e = simpleEnum.base

c.adjust()
c.simpleDescription

s.adjust()
s.simpleDescription

e.adjust()
e.getDescription()

// extension method to extend functionality
extension Int: exampleProtocol{
    var simpleDescription: String{
        return "The number is \(self)"
    }
    
    func addOne() -> Int{
        return self + 1
    }
    
    mutating func adjust() {
        self += 2
    }
}

var i = 9
i.adjust()
i.addOne()
i.simpleDescription

// generics
// generic function
func repeatItem<item>(a: item, times: Int) -> [item]{
    var result = [item]()
    for _ in 0..<times{
        result.append(a)
    }
    return result
}

print(repeatItem("hola", times: 5))
print(repeatItem(12, times: 2))

// add where condition in generics
func commonElements<T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element>(lhs: T, _ rhs: U) -> Bool{
    for l in lhs{
        for r in rhs{
            if l == r{
                return true
            }
        }
    }
    return false
}

commonElements([12,2,23,4], [1])

class genericNode<Item>{
    var data: Item?
    var next: genericNode?
}

class genericLinkedList<Item>{
    var head: genericNode<Item>?
    var printResult = [Item]()
    
    func add(data: Item){
        if head == nil{
            head = newElement(data)
        }else{
            var temp = head
            while(temp!.next != nil){
                temp = temp?.next
            }
            temp?.next = newElement(data)
        }
    }
    
    func printList() -> [Item]{
        printResult = []
        internalPrint(head)
        return printResult
    }
    
    func internalPrint(node: genericNode<Item>?){
        if node == nil{
            return
        }
        printResult.append(node!.data!)
        internalPrint(node!.next)
    }
    
    private func newElement(data: Item) -> genericNode<Item>{
        let newElem = genericNode<Item>()
        newElem.data = data
        newElem.next = nil
        return newElem
    }
}


var stringLL = genericLinkedList<String>()
stringLL.add("One")
stringLL.add("Two")
stringLL.add("Three")
stringLL.add("Four")
stringLL.printList()

var intLL = genericLinkedList<Int>()
intLL.add(1)
intLL.add(4)
intLL.add(2)
intLL.printList()

// typealias
typealias AudioSample = UInt8
let maxAmplitude = AudioSample.max

// Tuples
let http404error = (404, "Page not found")
http404error.0

// named value tuples
let http200message = (status: 200, message: "OK")
http200message.status
http200message.message

// ignore one value in tuple
let (responseCode, _) = http200message
responseCode

// unwrap nil with condition
if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber{
    print("\(firstNumber) and \(secondNumber)")
}

// error handling

enum MyError: ErrorType{
    case divideByZero
}

func divide(a: Int, b: Int) throws -> Int{
    if b == 0{
        throw MyError.divideByZero
    }
    
    return a/b
}

do{
    try divide(9, b: 0)
    print("will not reach here")
}catch MyError.divideByZero{
    print("divide by zero error")
}

// assert to catch any bug
let age = -3
// uncomment below to see in effect
//assert(age > 0, "Age can't be less than 0")
print("new line")

// remainder operator works on floating point as well
var a = 3.14
a % 2

// nil coalescing operator
var coalescingString: String?
coalescingString ?? "Other Value"

// get chars from String
for chars in "string test".characters{
    print(chars)
}

// string from chars
var ch: [Character] = ["T", "E", "S", "T"]
print(String(ch))

// append at the end of string
let exclamationMark: Character = "!"
message.append(exclamationMark)

// string interpolation
let multiplier = 3
"\(multiplier) times 2.5 is \((Double(multiplier) * 2.5))"
"\u{1F496}"

// character count
"hello".characters.count

let greetingMessage = "Greetings World!"
greetingMessage[greetingMessage.endIndex.predecessor()]
greetingMessage[greetingMessage.startIndex]
var idx = greetingMessage.startIndex.advancedBy(10)
greetingMessage[idx]

// acceses by indices
for index in greetingMessage.characters.indices{
    print("\(greetingMessage[index])", terminator: " ")
}

// inserting and removing string
var welcomeMessage = "Hello Hello"
welcomeMessage.insert("!", atIndex: welcomeMessage.startIndex)
welcomeMessage.insertContentsOf(" Hola Hola!".characters, at: welcomeMessage.endIndex)

// remove char from string
welcomeMessage.removeAtIndex(welcomeMessage.endIndex.predecessor())
welcomeMessage

// remove chars from string
let range = welcomeMessage.endIndex.advancedBy(-10)..<welcomeMessage.endIndex
welcomeMessage.removeRange(range)

// prefix suffix

welcomeMessage.hasPrefix("!")
welcomeMessage.hasSuffix("Hello")

print("")

// utf representation for a string
for codeUnit in welcomeMessage.utf8{
    print(codeUnit, terminator: " ")
}
print("")
for codeUnit in welcomeMessage.utf16{
    print(codeUnit, terminator: " ")
}

// Arrays
// shorthand init
let arr1 = [Int]()
// array init
let arr2 = Array<Int>()
// array with empty content
let arr3 = []
// array with default values
let arr4 = [Double](count: 10, repeatedValue: 0.4)

// two arrays can be merged with + operator
let arr5 = [Int](count: 3, repeatedValue: 1)
let arr6 = [Int](count: 3, repeatedValue: 2)
let arr7 = arr5 + arr6

// array init with values
var arr8 = [1, 2, 3]
arr8.append(9)
arr8 += [12, 43]
arr8[0...3]

// insert at index
arr8.insert(0, atIndex: 0)

// remove an element
arr8.removeRange(0...1)
print(arr8)

// remove last
arr8.removeLast()
arr8

// sets
var letters = Set<Character>()
for c in "letters".characters{
    letters.insert(c)
}

letters

// setting set to empty
letters = []
letters

// init set with array
var genre: Set<String> = ["Rock", "Clasical", "Hip Hop"]

// type is inferred if all types are same in array
var favGenres: Set = ["Rock", "Clasical", "Hip Hop"]

// use count to count elements
favGenres.count

// remove
favGenres.remove("Rock")
favGenres.insert("Jazz")

// contains
favGenres.contains("Jazz")

// loop
for g in favGenres{
    print(g)
}

// enumerate
for a in favGenres.enumerate(){
    print(a)
}

// set operations
var setA:Set = [2, 4, 6, 3]
var setB:Set = [1, 3, 5, 4]

// only common in both
setA.intersect(setB)

// values in both but not common
setA.exclusiveOr(setB)

// all together, dups are counted as one
setA.union(setB)

// subtract a to b to find unique in a
setA.subtract(setB)

// subtract b to a to find unique in b
setB.subtract(setA)

// two sets are equal if they have exact same elements
var setC = setA
setA == setC
setC == setB

// more set operations
var setD: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
var setE: Set = [2, 3, 5]
var setF: Set = [9, 10, 11, 12]
var setG: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// setE is subset of setD
setE.isSubsetOf(setD)

// setD is superset of setE
setD.isSupersetOf(setE)

// disjoint
setE.isDisjointWith(setF)

//strict subset
setG.isStrictSubsetOf(setD)

// strict superset
setG.isStrictSupersetOf(setD)


// dictionary
var dictionary1 = [Int: String]()
dictionary1[100] = "Hundred"
dictionary1

var dictionary2 = [String: String]()
dictionary2 = ["NY": "New York", "CA": "California"]

dictionary2.updateValue("ca", forKey: "CA")
dictionary2

dictionary2["NV"] = "Nevada"

// searching dictionary based on key
if let a = dictionary2["NV"]{
    print(a)
}else{
    print("No such state")
}

// removing from dictionary
dictionary2["Appl"] = "Apple State"
dictionary2
dictionary2["Appl"] = nil
dictionary2

// alternatively can use removeValueForKey
dictionary2.removeValueForKey("CA")
dictionary2

// for loop 
for (key, value) in dictionary2{
    print("key: \(key), value: \(value)")
}

// pring keys
for key in dictionary2.keys{
    print(key)
}

// print values
for value in dictionary2.values{
    print(value)
}

// convert dictionary values to array
var dictioanryValues = [String](dictionary2.values)


// snake ladder game
let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)
board[03] = +8
board[06] = +11
board[09] = +09
board[10] = +02

board[14] = -10
board[19] = -11
board[22] = -02
board[24] = -08

var square = 0
var diceRoll = 0
while square < finalSquare{
    diceRoll = Int(arc4random_uniform(6))
    
    square += diceRoll
    print("diceroll: \(diceRoll)")
    print("current square: \(square)")
    if square < board.count{
        square += board[square]
    }
}

print("Game over")

// switch case

let testString = "here is a test string"
switch testString{
case let x where x.characters.contains("a"):
    print("it has a vowel")
case let x where x.hasPrefix("here"):
    print(x)
case let x where x.containsString("test"):
    print(x)
default:
    print("default")
}

enum Sample{
    case sample1, sample2, sample3, sample4
}

let sampleTest = Sample.sample1

switch sampleTest{
case .sample1, .sample2:
    print("Either sample 1 or 2")
case .sample3, .sample4:
    print("Either sample 3 or 4")
    
}

// range match

let rangeSwitch = "This is just a sample"

switch rangeSwitch.characters.count{
case 0...10:
    print("10 chars")
case 10...20:
    print("Somewhere around 20")
case 20...30:
    print("More than 20")
default:
    print("At lot more than 20")
}

// tuple switch
let point = (1, 2)
switch point{
case let(x, y) where y < x:
    print("y is more than x")
case let(x, y):
    print("x: \(x), y:\(y)")
    fallthrough
default:
    print("Default executed")
}

// api supported by ios or not can be checked with if and available
if #available(iOS 9, OSX 10.10, *){
    print("these fetures are supported only on iOS 9 or up")
}else{
    print("fall back on old supported apis")
}

// swift functions support default values, param with default values are always last in the list
func sampleDefault(value: Int = 12) -> String{
    return "here is the value: \(value)"
}

sampleDefault()
sampleDefault(15)

// variadic param function can have 0 or more params
// variadic param: function can have at most one variadia param
func variadicFunction(value: Int...) -> String{
    return "Total count of numbers sent is : \(value.count)"
}

variadicFunction(12,2,3,4,5,6,0,7,8,76,5,9)

variadicFunction()

// function params are constant by default but can be modified by adding var infront to make them as variable
func addPadding(var str: String, totalLen: Int, pad: String) -> String{
    let lenTogo = totalLen - str.characters.count
    if lenTogo < 1{
        return str
    }

    for _ in 1...lenTogo{
        str = "\(pad)\(str)"
    }
    return str
}

addPadding("Hola", totalLen: 20, pad: "-")
addPadding("Como Esta!", totalLen: 20, pad: "-")

// swift supports in and out params where a variable can be passed and returned modified after the function call finishes
// inout params can't have default values or can't be of variadic type and also var or let can't be marked on inout params

func swapTwoInts(inout a: Int, inout b: Int){
    a = a + b
    b = a - b
    a = b - a
}
var a1 = 12
var b1 = 15
swap(&a1, &b1)
a1
b1

// functions as variables
func addTwoNumbers(num1: Int, num2: Int) -> Int{
    return num1 + num2
}

var delegateAdd = addTwoNumbers

print(delegateAdd(12,num2: 11))

// function as return type
func stepFwd(num: Int) -> Int{
    return num + 1
}

func stepBack(num: Int) -> Int{
    return num - 1
}

func computeStep(back: Bool) -> ((Int) -> Int){
    return back ? stepBack : stepFwd
}

var step = computeStep(true)
step(10)

// clousure 
var unsortedArray = ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
var sortedArray = unsortedArray.sort(){(s1: String, s2: String) in
    return s1 < s2
}

// type inferred
var sortedArray2 = unsortedArray.sort(){s1, s2 in return s1 < s2}
sortedArray2

// short hand version
var sortedArray3 = unsortedArray.sort{$0 > $1}
sortedArray3

// even shorter version
var sortedArray4 = unsortedArray.sort(<)

// trailing closure
func notifyAfterComplete(num: Int, completion: (String) -> Void){
    for _ in 0...num{
    
    }
    completion("all done")
}

notifyAfterComplete(100) { (val) -> Void in
    var completedVal = val
    print(completedVal)
}

// use of map
var digitNames = [1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]

var testDigits = [11, 15, 89, 78]
var stringDigits = testDigits.map { (var number) -> String in
    var output = ""
    while(number > 0){
        output = digitNames[number % 10]! + output
        number = number / 10
    }
    return output
}

// closures keep local values 
func IncrementParent(num: Int) -> (()->Int){
    var repeatSum = 0
    func IncrementChild() -> Int{
        for i in 0...num{
            repeatSum += i
        }
        return repeatSum
    }
    return IncrementChild
}

var incr = IncrementParent(10)
incr()

// autoclosures are used to delay execution for expensive operations
var customersInLine = ["Chris", "Mary", "Jane", "Adam"]

func serveNextCustomer(customer: () -> String){
    print("now serving \(customer())")
}

serveNextCustomer { customersInLine.removeAtIndex(0)}

// enums can store values with them
enum BarcodeType{
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productType = BarcodeType.UPCA(12, 11, 222, 1212)
var productType2 = BarcodeType.QRCode("ATESTQRCODE")

switch productType{
case .UPCA(let numberSystem, let manufacture, let product, let check):
    print("UPCA#:\(numberSystem)\(manufacture)\(product)\(check)")
case .QRCode(let code):
    print("QRCODE#:\(code)")
}

// enum with raw value
enum Planet: Int{
    case Sun = 1
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

// if type is given to enum then it gets an initializer that accepts raw values
var somePlanet = Planet(rawValue: 8)
if let p = somePlanet{
    switch p{
    case .Earth:
        print("Safe to live")
    default:
        print("Not sure about life yet")
    }
}

// === and !== uses
// === is used to check if two instances are identical meaning pointing to the same reference object
// its different from == which is check for equality
class TenEight{
    
}

let tenEight = TenEight()
let secondTenEight = tenEight
print("if two are equal \(tenEight === secondTenEight)")

// define expensive veriables with lazy keyword
class DataImporter{
    var fileName = "SomeFile.txt"
}

class DataManagement{
    lazy var importer = DataImporter()
    var data = [String]()
}

var dm = DataManagement()
dm.data.append("One")
dm.data.append("Two")

// this is where lazy property will initialized because its being utilized
dm.importer.fileName

// when used in multithreaded environ there is no gurantee for lazy property to get initialization only once

// computed property
struct Point{
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect{
    var origin = Point()
    var size = Size()
    
    var center: Point{
        get{
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter){
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}

var sq = Rect(origin: Point(x:0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
print("square.origin is \(sq.origin.x), \(sq.origin.y)")
var initSquareCenter = sq.center
sq.center = Point(x: 15.0, y: 15.0)
print("square.origin is \(sq.origin.x), \(sq.origin.y)")

// read only properties can be defined using following syntax
// no need to put get keyword when its a ready only property

struct Cuboid{
    var width = 0.0, height = 0.0, depth = 0.0
    
    var volume: Double{
        return width * height * depth
    }
}

let aCuboid = Cuboid(width: 10.0, height: 20.0, depth: 9)
aCuboid.volume

// property observer: works on any stored property as long as they are not attributed as lazy

class StepCounter{
    var totalSteps = 20{
        willSet{
            print("about to set new value to: \(newValue)")
        }
        didSet{
            print("just finished setting from old value \(oldValue)")
        }
    }
}

var stepCounter = StepCounter()
stepCounter.totalSteps = 90

// global constants and variable are always computed lazily

// type properties
struct Struct1{
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int{
        return 1
    }
}

enum Enum1{
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int{
        return 2
    }
}

class Class1 {
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty: Int{
        return 3
    }
}

Class1.computedTypeProperty
Class1.storedTypeProperty

// function in enum
enum TriStateSwitch{
    case Off, Low, High
    
    mutating func next(){
        switch self{
        case .Off:
            self = Low
        case .Low:
            self = High
        case .High:
            self = Off
        }
    }
}

var triSwitch = TriStateSwitch.Off
triSwitch.next()
triSwitch.next()
triSwitch.next()

// subscripts
class Multiplexer{
    private var multiplier = 0
    
    var Multiplier: Int{
        get{
            return multiplier
        }set{
            multiplier = newValue
        }
    }
    
    init(multiple: Int){
        self.Multiplier = multiple
    }
    
    subscript(index: Int) -> Int{
        return self.Multiplier * index
    }
}

var m1 = Multiplexer(multiple: 10)
print(m1[10])

// classes and inheritance 
class Vehicle{
    var currentSpeed = 0.0
    var description: String{
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise(){
        
    }
}

class Bicycle: Vehicle{
    var hasBasket = false
}

var vehicle = Bicycle()
vehicle.hasBasket = true
vehicle.currentSpeed = 10.0
vehicle.description

class Train: Vehicle{
    override func makeNoise() {
        print("Choo Choo")
    }
}

var train = Train()
train.makeNoise()

class Car: Vehicle{
    var gears = 0
    override func makeNoise() {
        print("broom broom on \(gears) gear")
    }
}

final class AutomaticCar: Car{
    override var currentSpeed: Double{
        didSet{
            gears = Int(currentSpeed / 10.0) + 1
        }
    }
}

var autoCar = AutomaticCar()
autoCar.currentSpeed = 100
autoCar.description
autoCar.makeNoise()

// mark class final to prevent overriding
//class newCar: AutomaticCar{}