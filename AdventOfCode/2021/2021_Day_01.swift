//
//  Day_1.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 30/11/2022.
//

import Foundation

func Day01_2021(data: [String.SubSequence]) {
    print("ℹ️ Day 1")
    let input = data.map { Int($0)!}
    print(Part_1(input: input))
}

private func Part_1(input: [Int]) -> Int {
    return zip(input, input.dropFirst())
            .lazy
            .filter{$0.0 < $0.1}
            .count
}
