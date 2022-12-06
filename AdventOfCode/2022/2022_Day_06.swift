//
//  2022_Day_06.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 06/12/2022.
//

import Foundation

func Day06_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 6")
    let input = data.map { String($0)}.first!
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: String) -> Int {
    var tmp:String = ""
    var counter = 0
    for i in 0..<input.count {
        var matchIndex:Int = 0
        if !tmp.contains(input[i]) {
            tmp += String(input[i])
        } else {
            for j in 0..<tmp.count {
                if input[i] == tmp[j] {
                    matchIndex = j+1
                }
            }
            tmp = tmp[matchIndex..<tmp.count]
            tmp += String(input[i])
        }
        if (tmp.count == 4) {
            counter = i+1
            break
        }
    }
    return counter
}

private func Part_2(input: String) -> Int {
    var tmp:String = ""
    var counter = 0
    for i in 0..<input.count {
        var matchIndex:Int = 0
        if !tmp.contains(input[i]) {
            tmp += String(input[i])
        } else {
            for j in 0..<tmp.count {
                if input[i] == tmp[j] {
                    matchIndex = j+1
                }
            }
            tmp = tmp[matchIndex..<tmp.count]
            tmp += String(input[i])
        }
        if (tmp.count == 14) {
            counter = i+1
            break
        }
    }
    return counter
}
