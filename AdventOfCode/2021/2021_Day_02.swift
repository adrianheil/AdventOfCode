//
//  2021_Day_02.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 04/12/2022.
//

import Foundation

func Day02_2021(data: [String.SubSequence]) {
    print("ℹ️ Day 2")
    let input = data.map { String($0)}
    
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}


private func Part_1(input: [String]) -> Int {
    var depth = 0, pos = 0
    for i in 0..<input.count {
        let split = input[i].components(separatedBy: " ")
        if split[0] == "forward" {
            pos += Int(split[1])!
        }
        else if split[0] == "down" {
            depth += Int(split[1])!
        }
        else if split[0] == "up" {
            depth -= Int(split[1])!
        }
    }
    return pos*depth
}

private func Part_2(input: [String]) -> Int {
    var depth = 0, pos = 0, aim = 0
    for i in 0..<input.count {
        let split = input[i].components(separatedBy: " ")
        if split[0] == "forward" {
            pos += Int(split[1])!
            depth += Int(split[1])! * aim
        }
        else if split[0] == "down" {
            aim += Int(split[1])!
        }
        else if split[0] == "up" {
            aim -= Int(split[1])!
        }
    }
    return pos*depth
}
