//
//  2022_Day_08.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 07/12/2022.
//

import Foundation

func Day08_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 8")
    let input = data.map { String($0)}
    
    print(Part_1(input: input))
    print(Part_2(input: input))
}

private func Part_1(input: [String]) -> Int {
    var visibleTree = 0
    
    for i in 0..<input.count {
    treeRow: for j in 0..<input[i].count {
        //MARK: get outer trees, all are visible from at least one side
        if i == 0 || j == 0 || i == input.count-1 || j == input.count-1 {
            visibleTree += 1
            continue treeRow
        }
        //MARK: get interior trees
        // visible from left
        for horizontal in 0..<j {
            // if any tree is larger, the tree is not visible from that side
            if input[i][j] <= input[i][horizontal] {
                break
            }
            
            if horizontal == j-1 {
                // if we have made it this far, the tree is visible
                visibleTree += 1
                continue treeRow
            }
        }
        // visible from right
        for horizontal in j+1..<input[i].count {
            // if any tree is larger, the tree is not visible from that side
            if input[i][j] <= input[i][horizontal] {
                break
            }
            
            if horizontal == input[i].count-1 {
                // if we have made it this far, the tree is visible
                visibleTree += 1
                continue treeRow
            }
        }
        
        // visible from top
        for vertical in 0..<i {
            // if any tree is larger, the tree is not visible from that side
            if input[i][j] <= input[vertical][j] {
                break
            }
            
            if vertical == i-1 {
                // if we have made it this far, the tree is visible
                visibleTree += 1
                continue treeRow
            }
        }
        
        // visible from bottom
        for vertical in i+1..<input.count {
            // if any tree is larger, the tree is not visible from that side
            // no need to check the remaining trees
            if input[i][j] <= input[vertical][j] {
                break
            }
            
            if vertical == input.count-1 {
                // if we have made it this far, the tree is visible
                visibleTree += 1
                continue treeRow
            }
        }
    }
    }
    return visibleTree
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
