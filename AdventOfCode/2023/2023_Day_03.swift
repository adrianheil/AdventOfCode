//
//  2023_Day_03.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 03/12/2023.
//

import Foundation

func Day03_2023() {
    print("ℹ️ Day 3")
    let input = readFile(filename: "Resources/2023_Day_3.txt").map { Array(String($0))}
    
    
    print(Part_1_2(for: input))
}

private func Part_1_2(for input: [[Character]]) -> (Int,Int) {
    var res_1 = 0, res_2 = 0
    for y in 0..<input.count {
        var x = 0
        while x < input[0].count {
            if input[y][x].isNumber {
                // erste Zahl gefunden, letzte finden
                var number: String = String(input[y][x])
                var lastDigitX = x
                while lastDigitX < input[y].count-1 &&
                        input[y][lastDigitX+1].isNumber {
                    lastDigitX += 1
                    number.append(input[y][lastDigitX])
                }
                isAdjacentGear(input: input, row: y, startCol: x, endCol: lastDigitX, number: Int(number)!)
                if isPartNumber(input: input, row: y, startCol: x, endCol: lastDigitX) {
                    res_1 += Int(number)!
                }
                x = lastDigitX+1
            } else {
                x += 1
            }
        }
    }
    
    //gültige Getriebe finden und Verhältnisse addieren
    for (_, partNumbers) in gears {
        if partNumbers.count == 2 {
            res_2 += partNumbers[0] * partNumbers[1]
        }
    }
    
    return(res_1, res_2)
}

private func isPartNumber(input: [[Character]], row: Int, startCol: Int, endCol: Int) -> Bool {
    let Ystart = max(row-1, 0)
    let Yend   = min(row+1, input.count-1)
    let Xstart = max(startCol-1, 0)
    let Xend   = min(endCol+1, input[row].count-1)
    for y in Ystart...Yend {
        for x in Xstart...Xend {
            if !input[y][x].isNumber && input[y][x] != "." {
                return true
            }
        }
    }
    return false
}

private func isAdjacentGear(input: [[Character]], row: Int, startCol: Int, endCol: Int, number: Int) {
    let Ystart = max(row-1, 0)
    let Yend   = min(row+1, input.count-1)
    let Xstart = max(startCol-1, 0)
    let Xend   = min(endCol+1, input[row].count-1)
    for y in Ystart...Yend {
        for x in Xstart...Xend {
            if input[y][x] == "*" {
                let point = GridPoint(x: x, y: y)
                gears[point] = gears[point] != nil ? gears[point]! + [number] : [number]
            }
        }
    }
}

private struct GridPoint:Hashable {
    var x: Int
    var y: Int
}

private var gears:[GridPoint:[Int]] = [:]
