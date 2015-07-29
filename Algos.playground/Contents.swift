//: Playground - noun: a place where people can play

import UIKit

// insertion sort demo
func insertSort(var arr: [Int]){
    for(var i = 0; i < arr.count; i++){
        for(var j = i; j > 0; j--){
            if(arr[j] < arr[j-1]){
                var temp = arr[j]
                arr[j] = arr[j - 1]
                arr[j - 1] = temp
            }
        }
       
    }
     println(arr)
}

insertSort([1,4,5,7,3,2,3,2,12])
// find value recursively
func findValueInArray(var arr:[Int], value: Int) -> Bool{
    if arr.isEmpty{
        return false
    }
    
    if arr[0] == value{
        return true
    }
    
    arr.removeAtIndex(0)
    return findValueInArray(arr, value)
}

//println(findValueInArray([1,2,3,4,5], 2))

// Mark: reverse the number
func reverseTheNumbers(number: Int) -> Int{
    return reverseInternal(number, 0)
}

func reverseInternal(number: Int, result: Int) -> Int{
    if number == 0 {
        return result
    }
    
    return reverseInternal(number / 10, result * 10 + number % 10)
}

//println(reverseTheNumbers(12331313))

// Mark: add numbers in given integer
func addTheNumbers(number: Int) -> Int{
    if number >= 0 && number < 10{
        return number
    }
    
    // 12
    // 21
    var divide = number / 10 // 1
    var remainder = number % 10 // 2
    return remainder + addTheNumbers(divide)
}

//println(addTheNumbers(123))

// Mark: Insertion sort
func sortArrayWithInsertionSort(var arr: [Int]) -> [Int]{
    for(var i = 0; i < arr.count; i++){
        var key = arr[i]
        println(key)
        for(var j = i; j > -1; j--){
            if(key < arr[j]){
                var temp = arr[j+1]
                arr[j+1] = arr[j]
                arr[j] = temp
            }
        }
    }
    return arr
}

// Mark: insertion sort check
//println(sortArrayWithInsertionSort([1,2,4,6,2, 3, 4, 566,8,9,3,5,7]))

// MARK: BFS
class BFS{
    func traverseBFS(root: Node?){
        if root == nil{
            return
        }
        var q = [Node]()
        q.append(root!)
        while(q.count != 0){
            var current = q.removeLast()
            println(current.data)
            if current.leftNode != nil{
                q.append(current.leftNode!)
            }
            if current.rightNode != nil{
                q.append(current.rightNode!)
            }
        }
    }
}

// Binary Tree
class Node{
    var data: Character?
    var leftNode: Node?
    var rightNode: Node?
    
    func insert(var root: Node?, d: Character) -> Node{
        if root == nil{
            root = Node()
            root!.data = d
            root!.leftNode = nil
            root!.rightNode = nil
        }else if(d <= root!.data){
            root!.leftNode = insert(root!.leftNode, d: d)
        }else{
            root!.rightNode = insert(root!.rightNode, d: d)
        }
        return root!
    }
}

// binary tree test
//var root = Node()
//root = root.insert(root, d: "X")
//root = root.insert(root, d: "A")
//root = root.insert(root, d: "C")
//root = root.insert(root, d: "Z")
//
//var bfs = BFS()
//bfs.traverseBFS(root)
// End BFS


// recurrsion :: fibbonacci
func fibonacci(number: Int) -> Int{
    if number == 0{
        return 0
    }
    if number == 1{
        return 1
    }
    return fibonacci(number - 1) + fibonacci(number - 2)
}

//fibonacci(20)

// recurrsion :: Factorial
func factorial(number: Int) -> Int{
    if number == 1{
        return 1
    }
    var result = number * factorial(number - 1)
    return result
}

// Mark: Insertion sort
func insertionSort(input: [Int], n: Int) -> [Int]{
    var i, j: Int
    var newInput = input
    for i = 1; i < n ; i++ {
        j = i
        while((j > 0 && (newInput[j] < newInput[j-1]))){
            var temp = newInput[j]
            newInput[j] = newInput[j - 1]
            newInput[j - 1] = temp
            j = j - 1
        }
    }
    return newInput
}


// Mark: tests for insertion sort
//var a = [1,34,45,653,232,4,2,56,245]
//insertionSort(a, 9)

// Mark: Question 5 An array contains n numbers ranging from 0 to n-2. There is exactly one number duplicated in the array. How do you find the duplicated number? For example, if an array with length 5 contains numbers {0, 2, 1, 3, 2}, the duplicated number is 2.
// Anoop
func findDup(arr: [Int]){
    var bcd = [Int]()
    for (var i = 0; i < arr.count; i++){
        if contains(bcd, arr[i]){
            println("found dup: \(arr[i])")
        }else{
            bcd.append(arr[i])
        }
    }
    println(bcd)
}

//findDup([0, 2, 1, 3, 2])

// book
func findDup2(arr : [Int]){
    var len = arr.count
    var sum1 = 0;
    for (var i = 0; i < len; i++){
        sum1 += arr[i]
    }
    var sum2 = ((len - 1) * (len - 2)) >> 1
    println(sum1 - sum2)
}

//findDup2([0, 5, 5, 3, 1])


