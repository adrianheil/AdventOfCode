//
//  2023_Day_04.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 04/12/2023.
//

import Foundation

func Day04_2023() {
    print("ℹ️ Day 4")
    let input = readFile(filename: "Resources/2023_Day_4.txt").map { String($0)}
    
    print(Part_1(for: input))
    print(Part_2(for: input))
}

private func Part_1(for input: [String]) -> Int {
    var res = 0.0
    for i in 0..<input.count {
        var countCard = -1
        let removeCard = input[i].split(separator: ": ")
        let numbers = removeCard[1].split(separator: " | ")
        let winningNumbers = numbers[0]
            .split(separator: " ")
            .map{Int($0)!}
        let myNumbers = numbers[1]
            .split(separator: " ")
            .map{Int($0)!}
        for j in 0..<winningNumbers.count {
            if myNumbers.contains(winningNumbers[j]) {
                countCard += 1
            }
        }
        if (countCard > -1) {
            res += pow(2, Double(countCard))
        }
    }
    return Int(res) 
}

private func Part_2(for input: [String]) -> Int {
    var res = Array(repeating: 1, count: input.count)
    for i in 0..<input.count {
        var countCard = 0
        let removeCard = input[i].split(separator: ": ")
        let numbers = removeCard[1].split(separator: " | ")
        let winningNumbers = numbers[0]
            .split(separator: " ")
            .map{Int($0)!}
        let myNumbers = numbers[1]
            .split(separator: " ")
            .map{Int($0)!}
        for j in 0..<winningNumbers.count {
            if myNumbers.contains(winningNumbers[j]) {
                countCard += 1
            }
        }
        if (countCard > 0) {
            for j in 1...countCard {
                if i+j > input.count {
                    continue
                }
                res[i+j] += res[i]
            }
        }
    }
    return res.reduce(0, +)
}
