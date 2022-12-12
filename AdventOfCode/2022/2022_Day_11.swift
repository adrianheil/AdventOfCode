//
//  2022_Day_11.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 11/12/2022.
//

import Foundation

class Monkey {
    var items:[Int] = []
    var operation:Character = " "
    var operationNumber: Int = 0
    var isUsingOld = false
    var inspections:Int = 0
    var testDiv:Int = 0
    var decisionThrowToMonkey:[Int] = [-1, -1]
}

func Day11_2022() {
    print("ℹ️ Day 11")
    let input = readFile(filename: "Resources/2022_Day_11.txt").map { String($0)}
    
    let numberOfMonkeys = input.filter {
        $0.contains("Monkey")
    }.count
    
    print(Throw(input: input, iterations: 20, numberOfMonkeys: numberOfMonkeys))
    print(Throw(input: input, iterations: 10000, numberOfMonkeys: numberOfMonkeys))
}

private func Throw(input: [String], iterations: Int, numberOfMonkeys: Int) -> Int {
    var monkeys:[Monkey] = []
    var monkey:Monkey?

    for line in input {
        if line.contains("Monkey") {
            monkey = Monkey()
        }
        else if line.contains("Starting items:") {
            let split = line.components(separatedBy: ": ")
            let itemLine = split[1].components(separatedBy: ", ")
            for i in 0..<itemLine.count {
                monkey?.items.append(Int(itemLine[i])!)
            }
            
        }
        else if line.contains("Operation:") {
            let split = line.components(separatedBy: " = ")[1]
            let split2 = split.components(separatedBy: " ")
            if split2[2] == "old" {
                monkey?.isUsingOld = true
                monkey?.operationNumber = 0
            } else {
                monkey?.isUsingOld = false
                monkey?.operationNumber = Int(split2[2])!
            }
        }
        else if line.contains("Test:") {
            monkey?.testDiv = Int(line.components(separatedBy: "by ")[1])!
        }
        else if line.contains("true") {
            monkey?.decisionThrowToMonkey[1] = Int(line.components(separatedBy: "monkey ")[1])!
        }
        else if line.contains("false") {
            monkey?.decisionThrowToMonkey[0] = Int(line.components(separatedBy: "monkey ")[1])!
            monkeys.append(monkey!) // last line in input
        }
    }
    let modulo = monkeys.map {$0.testDiv}
        .reduce(1, *)
    
    
    for _ in 0..<iterations {
        for monkeyNo in 0..<monkeys.count {
            let monkey = monkeys[monkeyNo]
            for item in 0..<monkey.items.count {
                if monkey.items[item] == 0 { continue }
                
                let number = monkey.isUsingOld ? monkey.items[item] : monkey.operationNumber
                
                var new = monkey.operation == "+" ? monkey.items[item] + number : monkey.items[item] * number
                if iterations == 20 {
                    new = new / 3
                }
                let test = new % monkey.testDiv == 0
                let newNew = new % modulo
                var nextMonkey = 0
                if test {
                    nextMonkey = monkey.decisionThrowToMonkey[1]
                }
                else {
                    nextMonkey = monkey.decisionThrowToMonkey[0]
                }
                var foundEmpty = false
                for i in 0..<monkeys[nextMonkey].items.count {
                    if monkeys[nextMonkey].items[i] == 0 {
                        monkeys[nextMonkey].items[i] = newNew
                        foundEmpty = true
                        break
                    }
                }
                if !foundEmpty {
                    monkeys[nextMonkey].items.append(newNew)
                }
                monkey.items[item] = 0
                monkey.inspections += 1
            }
        }
    }
    return monkeys.map {$0.inspections}
        .sorted(by: >)
        .prefix(2)
        .reduce(1, *)
}
