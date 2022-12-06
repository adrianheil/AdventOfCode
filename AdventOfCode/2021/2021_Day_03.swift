//
//  2021_Day_03.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 05/12/2022.
//

import Foundation

func Day03_2021(data: [String.SubSequence]) {
    print("ℹ️ Day 3")
    let input = data.map { String($0)}
    
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}


private func Part_1(input: [String]) -> Int {
    var gamma:String = ""
    var epsilon:String = ""
    for i in 0 ..< input[0].count { // assuming input with same columns
        var count_0 = 0
        var count_1 = 0
        for j in 0 ..< input.count {
            if input[j][i] == "0" {
                count_0 += 1
            }
            else if input[j][i] == "1" {
                count_1 += 1
            }
        }
        if count_0 > count_1 {
            gamma += "0"
            epsilon += "1"
        }
        else if count_0 < count_1 {
            gamma += "1"
            epsilon += "0"
        }
    }
    
    return Int(gamma, radix: 2)! * Int(epsilon, radix: 2)!
}

private func Part_2(input: [String]) -> Int {
    var oxigenArray = input
    var co2Array = input
    for i in 0 ..< input[0].count { // assuming input with same columns
        oxigenArray = getArrayOxigen(input: oxigenArray, i: i)
        co2Array = getArrayCO2(input: co2Array, i: i)
    }
    
    return Int(oxigenArray.first!, radix: 2)! * Int(co2Array.first!, radix: 2)!
}

private func getArrayOxigen(input: [String], i: Int) -> [String] {
    var input = input
    var count_0 = 0
    var count_1 = 0
    for j in 0 ..< input.count {
        if input[j][i] == "0" {
            count_0 += 1
        }
        else if input[j][i] == "1" {
            count_1 += 1
        }
    }
    
    if input.count == 1 {
        return input
    }
    if count_0 <= count_1 {
        input = input.filter { item in
            item[i] == "1"
        }
    } else {
        input = input.filter { item in
            item[i] == "0"
        }
    }
    return input
}

private func getArrayCO2(input: [String], i: Int) -> [String] {
    var input = input
    var count_0 = 0
    var count_1 = 0
    for j in 0 ..< input.count {
        if input[j][i] == "0" {
            count_0 += 1
        }
        else if input[j][i] == "1" {
            count_1 += 1
        }
    }
    
    if input.count == 1 {
        return input
    }
    
    if count_0 <= count_1 {
        input = input.filter { item in
            item[i] == "0"
        }
    } else {
        input = input.filter { item in
            item[i] == "1"
        }
    }
    return input
}
