//
//  2022_Day_11.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 11/12/2022.
//

import Foundation

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
    var items = [[Int]](repeating: [Int](repeating: 0, count: 10), count: numberOfMonkeys)
    var operation:[Character] = []
    var operationNumber: [Int] = []
    var isUsingOld:[Bool] = []
    var inspections = [Int](repeating: 0, count: numberOfMonkeys)
    var testDiv: [Int] = []
    var decisionThrowToMonkey = [[Int]](repeating: [Int](repeating: 255, count: 2), count: numberOfMonkeys)
    var currentMonkey = 0
    for line in input {
        if line.contains("Monkey") {
            currentMonkey = Int(line.components(separatedBy: " ")[1].alphanumeric)!
        }
        else if line.contains("Starting items:") {
            let split = line.components(separatedBy: ": ")
            let itemLine = split[1].components(separatedBy: ", ")
            for i in 0..<itemLine.count {
                items[currentMonkey][i] = Int(itemLine[i])!
            }
        }
        else if line.contains("Operation:") {
            let split = line.components(separatedBy: " = ")[1]
            let split2 = split.components(separatedBy: " ")
            operation.append(split2[1][0])
            if split2[2] == "old" {
                isUsingOld.append(true)
                operationNumber.append(0)
            } else {
                isUsingOld.append(false)
                operationNumber.append(Int(split2[2])!)
            }
        }
        else if line.contains("Test:") {
            testDiv.append(Int(line.components(separatedBy: "by ")[1])!)
        }
        else if line.contains("true") {
            decisionThrowToMonkey[currentMonkey][1] = Int(line.components(separatedBy: "monkey ")[1])!
        }
        else if line.contains("false") {
            decisionThrowToMonkey[currentMonkey][0] = Int(line.components(separatedBy: "monkey ")[1])!
        }
    }
    let modulo = testDiv.reduce(1, *)
    
    for _ in 0..<iterations {
        for monkey in 0..<numberOfMonkeys {
            for item in 0..<items[monkey].count {
                if items[monkey][item] == 0 { continue }
                
                let number = isUsingOld[monkey] ? items[monkey][item] : operationNumber[monkey]
                
                var new = operation[monkey] == "+" ? items[monkey][item] + number : items[monkey][item] * number
                if iterations == 20 {
                    new = new / 3
                }
                let test = new % testDiv[monkey] == 0
                let newNew = new % modulo
                var newMonkey = 0
                if test {
                    newMonkey = decisionThrowToMonkey[monkey][1]
                }
                else {
                    newMonkey = decisionThrowToMonkey[monkey][0]
                }
                var foundEmpty = false
                for i in 0..<items[newMonkey].count {
                    if items[newMonkey][i] == 0 {
                        items[newMonkey][i] = newNew
                        foundEmpty = true
                        break
                    }
                }
                if !foundEmpty {
                    items[newMonkey].append(newNew)
                }
                items[monkey][item] = 0
                inspections[monkey] += 1
            }
        }
    }
    return inspections.sorted(by: >)
        .prefix(2)
        .reduce(1, *)
}
