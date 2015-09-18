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