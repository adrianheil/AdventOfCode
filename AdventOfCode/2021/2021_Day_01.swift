//
//  Day_1.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 30/11/2022.
//

import Foundation

func Day01_2021() {
    print("ℹ️ Day 1")
    let input = readFile(filename: "Resources/2021_Day_1.txt").map { Int($0)!}
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [Int]) -> Int {
    return zip(input, input.dropFirst())
            .lazy
            .filter{$0.0 < $0.1}
            .count
}

private func Part_2(input: [Int]) -> Int {
    var windowArr:[Int] = []
    
    for i in 0..<input.count-2 {
        let tmp = input[i..<i+3].reduce(0, +)
        windowArr.append(tmp)
    }
    
    return zip(windowArr, windowArr.dropFirst())
        .lazy
        .filter{$0.0 < $0.1}
        .count
}

