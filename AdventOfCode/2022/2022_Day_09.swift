//
//  2022_Day_09.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 09/12/2022.
//

import Foundation

func Day09_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 9")
    let input = data.map { String($0)}
    
    print(MoveRope(input: input, ropeLength: 2))
    print(MoveRope(input: input, ropeLength: 10))
}

private func MoveRope(input: [String], ropeLength: Int) -> Int {
    var grid = [[UInt8]](repeating: [UInt8](repeating: 0, count: 1000), count: 1000)
    var pos = [[Int]](repeating: [Int](repeating: 333, count: 2), count: 10)
    for line in input {
        let split = line.components(separatedBy: " ")
        let direction = getDirection(letter: split[0][0])
        
        for _ in 0..<Int(split[1])! {
            pos[0][0] += direction[0]
            pos[0][1] += direction[1]
            for i in 1..<ropeLength {
                if pos[i-1][0] > pos[i][0] + 1 {
                    pos[i][0]+=1
                    if pos[i-1][1] > pos[i][1] {
                        pos[i][1]+=1
                    }
                    else if pos[i-1][1] < pos[i][1] {
                        pos[i][1]-=1
                    }
                }
                else if pos[i-1][0] < pos[i][0] - 1 {
                    pos[i][0]-=1
                    if pos[i-1][1] > pos[i][1] {
                        pos[i][1]+=1
                    }
                    else if pos[i-1][1] < pos[i][1] {
                        pos[i][1]-=1
                    }
                }
                else if pos[i-1][1] > pos[i][1] + 1 {
                    pos[i][1]+=1
                    if pos[i-1][0] > pos[i][0] {
                        pos[i][0]+=1
                    }
                    else if pos[i-1][0] < pos[i][0] {
                        pos[i][0]-=1
                    }
                }
                else if pos[i-1][1] < pos[i][1] - 1 {
                    pos[i][1]-=1
                    if pos[i-1][0] > pos[i][0] {
                        pos[i][0]+=1
                    }
                    else if pos[i-1][0] < pos[i][0] {
                        pos[i][0]-=1
                    }
                    
                }
                
            }
            grid[pos[ropeLength-1][0]][pos[ropeLength-1][1]] = 1
        }
    }
    
    return grid
        .map {
            $0.map {
                Int($0)
            }.reduce(0, +)
        }.reduce(0, +)
}

private func getDirection(letter: Character) -> [Int] {
    if letter == "R" {
        return [0,1]
    }
    else if letter == "L" {
        return [0,-1]
    }
    else if letter == "U" {
        return [1,0]
    }
    else if letter == "D" {
        return [-1,0]
    } else {
        return [0,0]
    }
}
