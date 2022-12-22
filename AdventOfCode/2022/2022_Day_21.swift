//
//  2022_Day_21.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 21/12/2022.
//

import Foundation
import Numerics

func Day21_2022() {
    print("ℹ️ Day 21")
    let input = readFile(filename: "Resources/2022_Day_21.txt").compactMap { String($0)}
    
    Part_1(input: input)
    Part_2(input: input)
}

private func Part_1(input: [String]) {
    
    var input = input
    var monkey = [String: Int]()
    
    while !input.isEmpty {
        for (i, item) in input.enumerated().reversed() {
            let split = item.components(separatedBy: ": ")
            if Int(split[1]) != nil {
                monkey[split[0]] = Int(split[1])
                input.remove(at: i)
            } else {
                let operation = split[1].components(separatedBy: " ")
                let leftNumber = monkey[operation[0]]
                let rightNumber = monkey[operation[2]]
                if leftNumber != nil && rightNumber != nil {
                    let number = calc(operation: operation[1], leftNumber: leftNumber!, rightNumber: rightNumber!)
                    monkey[split[0]] = number
                    input.remove(at: i)
                }
            }
        }
    }
    print(monkey["root"]!)
}

private func Part_2(input: [String]) {
    var input = input
    let rootLine = input.filter { line in
        line.contains("root")
    }.first!
    let rootSplit = rootLine.components(separatedBy: ": ")[1].components(separatedBy: " ")
    let testPhrase_1 = rootSplit[0]
    let testPhrase_2 = rootSplit[2]
    
    
    let humnLine = input.filter { line in
        line.contains("humn:")
    }.first!
    // remove humn
    input.remove(at: input.firstIndex(of: humnLine)!)
    
    var monkey = [String: Complex<Double>]()
    input.append("humn: noneed")
    
    while !input.isEmpty {
        for (i, item) in input.enumerated().reversed() {
            let split = item.components(separatedBy: ": ")
            if split[0].contains("humn") {
                monkey[split[0]] = Complex<Double>(0, 1)
                input.remove(at: i)
            }
            else if Int(split[1]) != nil {
                monkey[split[0]] = Complex(Double(split[1])!)
                input.remove(at: i)
            } else {
                let operation = split[1].components(separatedBy: " ")
                let leftNumber = monkey[operation[0]]
                let rightNumber = monkey[operation[2]]
                if leftNumber != nil && rightNumber != nil {
                    let number = complexCalc(operation: operation[1], leftNumber: leftNumber!, rightNumber: rightNumber!)
                    monkey[split[0]] = number
                    input.remove(at: i)
                }
            }
        }
    }
    print(Int((monkey[testPhrase_2]!.real - monkey[testPhrase_1]!.real)/((monkey[testPhrase_1]!.imaginary + monkey[testPhrase_2]!.imaginary))))
}

private func complexCalc(operation: String, leftNumber: Complex<Double>, rightNumber: Complex<Double>) -> Complex<Double> {
    switch operation {
    case "+": return leftNumber + rightNumber
    case "-": return leftNumber - rightNumber
    case "*": return leftNumber * rightNumber
    case "/": return leftNumber / rightNumber
    default: return 0
    }
}

private func calc(operation: String, leftNumber: Int, rightNumber: Int) -> Int {
    switch operation {
    case "+": return leftNumber + rightNumber
    case "-": return leftNumber - rightNumber
    case "*": return leftNumber * rightNumber
    case "/": return leftNumber / rightNumber
    default: return 0
    }
}
