//
//  2023_Day_02.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 02/12/2023.
//

import Foundation


func Day02_2023() {
    print("ℹ️ Day 2")
    let input = readFile(filename: "Resources/2023_Day_2.txt").map { String($0)}
    
 

    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    var game = 0
    let red = 12
    let green = 13
    let blue = 14
    
    outer: for i in 0..<input.count {
        let split = input[i].components(separatedBy: ": ")
        let game_number = split[0].components(separatedBy: " ")[1]
        // ich brauche nicht über die einzelnen Subspiele gehen um zu erkennen ob ein Spiel unmöglich ist
        let replaced_split = split[1].replacingOccurrences(of: ";", with: ",")
        let moves = replaced_split.components(separatedBy: ", ")
        
        for j in 0..<moves.count {
            let split_move = moves[j].components(separatedBy: " ")
            let num = Int(split_move[0])!
            let colour = split_move[1]
            
            if colour == "red" && num > red {
                continue outer
            }
            else if colour == "green" && num > green {
                continue outer
            }
            else if colour == "blue" && num > blue {
                continue outer
            }
        }
        game += Int(game_number)!
    }
    return game
}

private func Part_2(input: [String]) -> Int {
    var game = 0

    
    outer: for i in 0..<input.count {
        
        var red = 0
        var green = 0
        var blue = 0
        
        let split = input[i].components(separatedBy: ": ")

        // ich brauche nicht über die einzelnen Subspiele gehen um zu erkennen ob ein Spiel unmöglich ist
        let replaced_split = split[1].replacingOccurrences(of: ";", with: ",")
        let moves = replaced_split.components(separatedBy: ", ")
        
        for j in 0..<moves.count {
            let split_move = moves[j].components(separatedBy: " ")
            let num = Int(split_move[0])!
            let colour = split_move[1]
            
            if colour == "red" && num > red {
                red = num
            }
            else if colour == "green" && num > green {
                green = num
            }
            else if colour == "blue" && num > blue {
                blue = num
            }
        }
        let power = red * green * blue
        
        game += power
    }
    return game
}

