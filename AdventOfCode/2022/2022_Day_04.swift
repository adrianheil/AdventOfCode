//
//  2022_Day_04.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 04/12/2022.
//

import Foundation

func Day04_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 4")
    let input = data.map { String($0)}
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    return input.map { item in
        let split = item.components(separatedBy: ",")
        let first = split[0].components(separatedBy: "-").map{Int($0)!}
        let second = split[1].components(separatedBy: "-").map{Int($0)!}
        if  first[0] <= second[0] && first[1] >= second[1]  { // is the first fully containing the second?
            return 1
        }
        else if  second[0] <= first[0] && second[1] >= first[1]  { // is the secod fully containing the first?
            return 1
        }
        else { return 0 }
    }
    .reduce(0, +)
}

private func Part_2(input: [String]) -> Int {
    return input.map { item in
        let split = item.components(separatedBy: ",")
        let first = split[0].components(separatedBy: "-").map{Int($0)!}
        let second = split[1].components(separatedBy: "-").map{Int($0)!}
        if first[0] >= second[0] && first[0] <= second[1] {
            return 1
        }
        else if second[0] >= first[0] && second[0] <= first[1] {
            return 1
        }
        else { return 0 }
    }
    .reduce(0, +)
}
