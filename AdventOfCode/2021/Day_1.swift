//
//  Day_1.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 30/11/2022.
//

import Foundation

func countIncreases(data: [String.SubSequence]) -> Int {
    let input = data.map { Int($0)!}
    return zip(input, input.dropFirst())
            .lazy
            .filter{$0.0 < $0.1}
            .count
}
