//
//  SortingViewController.swift
//  DSA
//
//  Created by Anoop tomar on 10/19/15.
//  Copyright © 2015 Anoop tomar. All rights reserved.
//

import UIKit

class SortingViewController: UIViewController {
    
    var algoType: AlgoType?
    var inputArray: [Int] = []
    
    @IBOutlet weak var sortingInput: UILabel!
    @IBOutlet weak var sortingAlgoName: UILabel!
    @IBOutlet weak var sortingOutput: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let desc = algoType{
            sortingAlgoName.text = desc.desciption
        }
    }
 
    @IBAction func didGenerateNumbers(sender: UIButton) {
        inputArray = []
        for _ in 0..<10{
            inputArray.append(Int(arc4random_uniform(500)))
        }
        sortingInput.text = "\(inputArray)"
        sortingAlgorithm()
    }
    
    func sortingAlgorithm(){
        switch algoType!{
        case .InsertionSort:
            insertionSort()
        case .BubbleSort:
            sortingOutput.text = "BubbleSort"
        case .MergeSort:
            sortingOutput.text = "Merge Sort"
        case .QuickSort:
            quickSort()
        case .SelectionSort:
            selectionSort()
        }
    }
    
    func insertionSort(){
        var x, y, key: Int
        for (x = 0; x < inputArray.count; x++){
            key = inputArray[x]
            print("x value \(x)")
            for (y = x; y > -1; y--){
                print("y value \(y)")
                print("key vs input[y]: \(key) < \(inputArray[y])")
                print("input array")
                print(inputArray)
                if (key < inputArray[y]){
                    print("y: \(inputArray[y])")
                    print("y+1: \(inputArray[y+1])")
                    let elem = inputArray.removeAtIndex(y+1)
                    print("key \(key)")
                    print("removed \(elem)")
                    print("input array before insert after removal")
                    print(inputArray)
                    inputArray.insert(key, atIndex: y)
                    print("input array after insert")
                    print(inputArray)
                }
            }
        }
        sortingOutput.text = "\(inputArray)"
    }
    
    func selectionSort(){
        for(var i = 0; i < inputArray.count; i++){
            var min = i
            for(var j = i+1; j < inputArray.count; j++){
                if inputArray[j] < inputArray[min]{
                    min = j
                    
                }
            }
            let temp = inputArray[i]
            inputArray[i] = inputArray[min]
            inputArray[min] = temp
        }
        sortingOutput.text = "\(inputArray)"
    }
    
    func quickSort(){
        quickSort(0, right: inputArray.count - 1)
        sortingOutput.text = "\(inputArray)"
    }
    
    private func quickSort(left: Int, right: Int){
        var i = left
        var j = right
        var temp = -1
        let pivot = inputArray[(left+right)/2]
        while(i <= j){
            while(inputArray[i] < pivot) {
                i++
            }
            while(inputArray[j] > pivot){
                j--
            }
            if (i <= j){
                temp = inputArray[i]
                inputArray[i] = inputArray[j]
                inputArray[j] = temp
                i++
                j--
            }
        }
        if(left < j){
            quickSort(left, right: j)
        }
        if(i < right){
            quickSort(i, right: right)
        }
    }
}
