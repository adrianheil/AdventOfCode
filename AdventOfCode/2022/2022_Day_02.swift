//
//  2022_Day_02.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 02/12/2022.
//

import Foundation

func Day02_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 2")
    let input = data.map { String($0)}

    
    print(Part_1(input: input))
    print(Part_2(input: input))
}
//13359


private func Part_1(input: [String]) -> Int {
    var score = 0
    for i in 0..<input.count {
        let split = input[i].components(separatedBy: " ")
        if split[1] == "X" {
            score += 1
            if split[0] == "A" { //rock
                score += 3 // draw
            }
            else if split[0] == "B" {
                score += 0 // loss
            }
            else if split[0] == "C" {
                score += 6 // win
            }
        }
        else if split[1] == "Y" { //paper
            score += 2
            if split[0] == "A" {
                score += 6 // win
            }
            else if split[0] == "B" {
                score += 3 // draw
            }
            else if split[0] == "C" {
                score += 0 // los
            }
        }
        else if split[1] == "Z" { //scissors
            score += 3
            if split[0] == "A" {
                score += 0 // loss
            }
            else if split[0] == "B" {
                score += 6 // win
            }
            else if split[0] == "C" {
                score += 3 // draw
            }
        }
    }
    return score
}

private func Part_2(input: [String]) -> Int {
    var score = 0
    for i in 0..<input.count {
        let split = input[i].components(separatedBy: " ")
        if split[1] == "X" {
            score += 0 //loss
            if split[0] == "A" { //rock
                score += 3 // s
            }
            else if split[0] == "B" {
                score += 1 // r
            }
            else if split[0] == "C" {
                score += 2 // p
            }
        }
        else if split[1] == "Y" { //draw
            score += 3
            if split[0] == "A" {
                score += 1 // r
            }
            else if split[0] == "B" {
                score += 2 // p
            }
            else if split[0] == "C" {
                score += 3 // s
            }
        }
        else if split[1] == "Z" { //win
            score += 6
            if split[0] == "A" {
                score += 2 // p
            }
            else if split[0] == "B" {
                score += 3 // s
            }
            else if split[0] == "C" {
                score += 1 // r
            }
        }
    }
    return score
}
