//
//  2022_Day_05.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 05/12/2022.
//

import Foundation

func Day05_2022() {
    print("ℹ️ Day 5")
    let input = readFile(filename: "Resources/2022_Day_5.txt").map { String($0)}
    var blockIndex = 0
    for i in 0..<input.count {
        if input[i] == "block" {
            blockIndex = i
            break
        }
    }
    let cratesInput = input[0 ..< blockIndex-1]
    let moves = Array(input[blockIndex+1 ..< input.count])
    
    // get number of crates to arrange the input
    let numberOfStacks = Int(input[blockIndex-1].components(separatedBy: " ").last!)!
    
    var stacks:[String] = []
    
    // catch empty stacks between crate stacks and remove braces
    for i in 0 ..< blockIndex-1 {
        stacks.append(cratesInput[i]
            .replacingOccurrences(of: "                           ", with: "0 0 0 0 0 0 0")
            .replacingOccurrences(of: "                       ", with: "0 0 0 0 0 0")
            .replacingOccurrences(of: "                   ", with: "0 0 0 0 0")
            .replacingOccurrences(of: "               ", with: "0 0 0 0")
            .replacingOccurrences(of: "           ", with: "0 0 0")
            .replacingOccurrences(of: "       ", with: "0 0")
            .replacingOccurrences(of: "   ", with: "0")
            .alphanumeric)
    }
    //initialise array and transpose the input
    let maxCrates = numberOfStacks * cratesInput.count-1
    var cratesArr = [[Character]](repeating: [Character](repeating: " ", count: maxCrates), count: numberOfStacks)
    for i in 0..<stacks.count {
        for j in 0..<stacks[i].count {
            if stacks[i][j] != "0" {
                cratesArr[j][i] = stacks[i][j]
            }
            
        }
    }
    var crates:[String] = []
    for i in 0..<cratesArr.count {
        let str = String(cratesArr[i])
            .alphanumeric
            .reversed()
        crates.append(String(str))
    }
    
    print(Part_1(cratesInput: crates, moves: moves))
    print(Part_2(cratesInput: crates, moves: moves))
}

private func Part_1(cratesInput: [String], moves: [String]) -> String {
    var crates = cratesInput
    for i in 0 ..< moves.count {
        let split = moves[i].components(separatedBy: " ")
        let numberOfCrates = Int(split[1])!
        let from = Int(split[3])! - 1
        let to = Int(split[5])! - 1
        
        for _ in 0 ..< numberOfCrates {
            let stackHeight:Int = crates[from].count
            crates[to] += crates[from][stackHeight-1 ..< stackHeight]
            crates[from] = crates[from][0 ..< stackHeight-1]
        }
    }
    var res:String = ""
    for i in 0 ..< cratesInput.count {
        res += String(crates[i].last!).uppercased()
    }
    return res
}

private func Part_2(cratesInput: [String], moves: [String]) -> String {
    var crates = cratesInput
    for i in 0 ..< moves.count {
        let split = moves[i].components(separatedBy: " ")
        let numberOfCrates = Int(split[1])!
        let from = Int(split[3])! - 1
        let to = Int(split[5])! - 1
        
        let stackHeight:Int = crates[from].count
        crates[to] += crates[from][stackHeight-numberOfCrates ..< stackHeight]
        crates[from] = crates[from][0 ..< stackHeight-numberOfCrates]
    }
    var res:String = ""
    for i in 0 ..< cratesInput.count {
        res += String(crates[i].last!).uppercased()
    }
    return res
}
