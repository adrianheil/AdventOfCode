//
//  Day_1_1.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 01/12/2022.
//

import Foundation


func Day01_2023() {
    print("ℹ️ Day 1")
    let input = readFile(filename: "Resources/2023_Day_1.txt").map { String($0)}
    /*var cal = 0
    var res:[Int] = []
    for line in input {
        if line != "block" {
            cal += Int(line)!
        } else {
            res.append(cal)
            cal = 0
        }
    }*/
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    var count = 0
    for i in 0..<input.count{
        let res = firstAndLast(input[i])
        count += Int(res)!
    }
    return count
}

private func Part_2(input: [String]) -> Int {
    

    
    var count = 0
    for i in 0..<input.count{

        var replaced = input[i]
        replaced = replaced.replacingOccurrences(of: "nine", with: "n9e")
        replaced = replaced.replacingOccurrences(of: "eight", with: "e8t")
        replaced = replaced.replacingOccurrences(of: "seven", with: "s7n")
        replaced = replaced.replacingOccurrences(of: "six", with: "s6x")
        replaced = replaced.replacingOccurrences(of: "five", with: "f5e")
        replaced = replaced.replacingOccurrences(of: "four", with: "f4r")
        replaced = replaced.replacingOccurrences(of: "three", with: "t3e")
        replaced = replaced.replacingOccurrences(of: "two", with: "t2o")
        replaced = replaced.replacingOccurrences(of: "one", with: "o1e")
        
        
        
        
        
        
        
        
        //replaced = replaced.replacingOccurrences(of: "zero", with: "0")
        let res = firstAndLast(replaced)
        if i == 15 {
            print(input[i])
            print(replaced)
            print(res)
        }
        count += Int(res)!
    }
    return count
}
 


func firstAndLast(_ string: String) -> (String) {
    guard let start = string.firstIndex(where: { $0.isNumber }) else {
        return("1")
    }

    
    guard let end = string.lastIndex(where: { $0.isNumber }) else {
        return("2")
    }
    
    //return(start, end)
    
    let cat = String(string[start]) + String(string[end])
    
    return(cat)
    
    //return (Int(string.prefix(upTo: start)) ?? 0, Int(string.suffix(from: string.index(end, offsetBy: 1))) ?? 0)
}
