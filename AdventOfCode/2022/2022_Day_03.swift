//
//  2022_Day_03.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 03/12/2022.
//

import Foundation

func Day03_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 3")
    let input = data.map { String($0)}
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    var count = 0
    for i in 0..<input.count {
        let split = input[i].splitByLength(by: input[i].count/2)
        for j in 0..<split[0].count {
            if split[1].contains(split[0][j]) {
                let char:Character = split[0][j]
                let prio:UInt8 = char.isLowercase ? char.asciiValue! - 96 : char.asciiValue! - 38
                
                count += Int(prio)
                break
            }
        }
    }
    return count
}

private func Part_2(input: [String]) -> Int {
    var count = 0
    for i in stride(from: 0, to: input.count, by: 3) {
    outerloop: for j in 0..<input[i+1].count {
            for k in 0..<input[i+2].count {
                if (input[i].contains(input[i+1][j]) && input[i+1][j] == input[i+2][k]) {
                    let char:Character = input[i+1][j]
                    let prio:UInt8 = char.isLowercase ? char.asciiValue! - 96 : char.asciiValue! - 38
                    
                    count += Int(prio)
                    break outerloop
                }
            }
        }
    }
    return count
}
