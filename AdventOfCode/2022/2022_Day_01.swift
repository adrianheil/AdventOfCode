//
//  Day_1_1.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 01/12/2022.
//

import Foundation


func Day01_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 1")
    let input = data.map { String($0)}
    //input = input.components("block")
    //print(input)
    var cal = 0
    var res:[Int] = []
    for i in 0..<input.count {
        if input[i] != "block" {
            cal = cal + Int(input[i])!
        } else {
            res.append(cal)
            cal = 0
        }
    }
    print(Part_1(input: res))
    print(Part_2(input: res))
}

private func Part_1(input: [Int]) -> Int {
    return input.max()!
}

private func Part_2(input: [Int]) -> Int {
    return input
        .sorted(by: >)
        .prefix(3)
        .reduce(0) { $0 + $1 }
}
