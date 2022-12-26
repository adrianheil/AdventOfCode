//
//  2022_Day_25.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 26/12/2022.
//

import Foundation

private var SNAFUS: [String] = []
private let toDigit: [Character: Int] = [ "2": 2, "1": 1, "0": 0, "-": -1, "=": -2 ]
private let fromDigit: [Int: String] =  [ 2: "2", 1: "1", 0: "0", -1: "-", -2: "=" ]

func Day25_2022() {
    print("ℹ️ Day 25")
    let input = readFile(filename: "Resources/2022_Day_25.txt").compactMap { String($0)}
    
    Part_1(input: input)
}

private func Part_1(input: [String]) {
    SNAFUS = input
    let sum = SNAFUS.reduce(0) { $0 + convert($1) }
    print(toSnafu(sum))
}

private func convert(_ s: String) -> Int {
    s.reduce(0) {
        $0 * 5 + toDigit[$1]!
    }
}

private func toSnafu(_ i: Int) -> String {
    if i == 0 {
        return ""
    }
    let modulo5 = i % 5
    switch modulo5 {
    case 0, 1, 2: return toSnafu(i / 5) + fromDigit[modulo5]!
    case 3, 4: return toSnafu(i / 5 + 1) + fromDigit[modulo5 - 5]!
    default: fatalError()
    }
}

