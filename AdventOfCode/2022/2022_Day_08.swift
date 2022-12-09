//
//  2022_Day_08.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 07/12/2022.
//

import Foundation

func Day08_2022() {
    print("ℹ️ Day 8")
    let input = readFile(filename: "Resources/2022_Day_8.txt").map { String($0)}
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    var visibleTrees = 0
    for i in 0..<input.count {
        for j in 0..<input[i].count {
            if i == 0 || j == 0 || i == input.count-1 || j == input.count-1 {
                visibleTrees+=1
                continue
            }
            var isVisible = [true, true, true, true]
            for horizontal in 0..<j {
                if input[i][j] <= input[i][horizontal] {
                    isVisible[0] = false
                    break
                }
            }
            for horizontal in j+1..<input[i].count {
                // if any tree is larger, the tree is not visible from that side
                if input[i][j] <= input[i][horizontal] {
                    isVisible[1] = false
                    break
                }
            }
            for vertical in 0..<i {
                if input[i][j] <= input[vertical][j] {
                    isVisible[2] = false
                    break
                }
            }
            for vertical in i+1..<input.count {
                if input[i][j] <= input[vertical][j] {
                    isVisible[3] = false
                    break
                }
            }
            if isVisible.contains(true) {
                visibleTrees+=1
            }
        }
    }
    return visibleTrees
}

private func Part_2(input: [String]) -> Int {
    var distArray = [0, 0, 0, 0]
    var dist = 0
    for i in 0..<input.count {
        for j in 0..<input[i].count {
            // skip trees at the edge, always 0
            if i == 0 || j == 0 || i == input.count-1 || j == input.count-1 {
                continue
            }
            for horizontal in stride(from: j-1, through: 0, by: -1) {
                if input[i][j] <= input[i][horizontal] {
                    distArray[0] = j-horizontal //+ 1
                    break
                }
                
                if horizontal == j-1 {
                    distArray[0] = j //count all trees, clear line of sight
                }
            }
            for horizontal in j+1..<input[i].count {
                if input[i][j] <= input[i][horizontal] {
                    distArray[1] = horizontal - j
                    break
                }
                
                if horizontal == input[i].count-1 {
                    distArray[1] = horizontal - j
                }
            }
            
            for vertical  in stride(from: i-1, through: 0, by: -1) {
                if input[i][j] <= input[vertical][j] {
                    distArray[2] = i-vertical //+ 1
                    break
                }
                
                if vertical == i-1 {
                    distArray[2] = i
                }
            }
            
            for vertical in i+1..<input.count {
                if input[i][j] <= input[vertical][j] {
                    distArray[3] = vertical - i
                    break
                }
                
                if vertical == input.count-1 {
                    distArray[3] = vertical - i
                }
            }
            
            let tmp = distArray.reduce(1, *)
            if tmp > dist {
                dist = tmp
            }
        }
    }
    return dist
}
