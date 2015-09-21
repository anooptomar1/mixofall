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

