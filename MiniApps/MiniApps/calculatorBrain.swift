//
//  calculatorBrain.swift
//  MiniApps
//
//  Created by Anoop tomar on 6/18/15.
//  Copyright (c) 2015 Anoop tomar. All rights reserved.
//

import Foundation
class CalculatorBrain {
    var opStack = [Op]()
    
    var knownOperations = [String: Op]()
    
    enum Op: Printable{
        case operand(value: Double)
        case unaryOperation(symbol: String, Double -> Double)
        case binaryOperation(symbol: String, (Double, Double) -> Double)
        
        var description: String{
            get{
                switch self{
                case .operand(let opValue):
                    return "\(opValue)"
                case .unaryOperation(let symbol,_):
                    return "\(symbol)"
                case .binaryOperation(let symbol,_):
                    return "\(symbol)"
                }
            }
        }
    }
    
    func evaluate(ops: [Op]) -> (result: Double?, ops: [Op]){

        if(!ops.isEmpty){
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .operand(let operand):
                return (operand, remainingOps)
            case .binaryOperation(_, let operation):
                let op1 = evaluate(remainingOps)
                if let op1Eval = op1.result{
                    let op2 = evaluate(op1.ops)
                    if let op2Eval = op2.result{
                        return (operation(op1Eval, op2Eval), op2.ops)
                    }
                }
            case .unaryOperation(_, let operation):
                var op1 = evaluate(remainingOps)
                if let op1Eval = op1.result{
                    return (operation(op1Eval),remainingOps)
                }
            }
        }
        return (nil, ops)
    }
    
    
    func evaluate(){
        var (result, remainingOps) = evaluate(opStack)
        println("result: \(result), remaining Ops: \(remainingOps)")
    }
    
    init(){
        
        func learnOp(op: Op){
            knownOperations[op.description] = op
        }
        
        learnOp(Op.binaryOperation(symbol: "+"){ $0 + $1 })
        learnOp(Op.binaryOperation(symbol: "-"){ $1 - $0 })
        learnOp(Op.binaryOperation(symbol: "*"){ $0 * $1 })
        learnOp(Op.binaryOperation(symbol: "/"){ $1 / $0 })
        learnOp(Op.unaryOperation(symbol: "sqrt"){ sqrt($0) })
    }
    
    func pushOperand(operandValue: Double){
        opStack.append(Op.operand(value: operandValue))
    }
    
    func performOperation(symbol: String){
        if let operation = knownOperations[symbol]{
            opStack.append(operation)
        }
    }
    
}