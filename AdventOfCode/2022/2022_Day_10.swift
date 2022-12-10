//
//  2022_Day_10.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 10/12/2022.
//

import Foundation

func Day10_2022() {
    print("ℹ️ Day 10")
    let input = readFile(filename: "Resources/2022_Day_10.txt").map { String($0)}
    print(Part_01(input: input))
    print(Part_02(input: input))
}

private func Part_01(input: [String]) -> Int {
    var cycle:[Int] = []
    cycle.append(0) // add dummy value for easier
    var x = 1
    for line in input {
        let split = line.components(separatedBy: " ")
        cycle.append(x)
        if split[0].contains("addx") {
            x += Int(split[1])!
            cycle.append(x)
        }
    }
    var result = 0
    for i in stride(from: 20, to: 221, by: 40) {
        result += i*cycle[i-1]
    }
    return result
}

private func Part_02(input: [String]) {
    var CRTLine:String = ""
    var x = 0
    var cycle = 0
    var CRT:[String] = []
    for line in input {
        let split = line.components(separatedBy: " ")
        cycle += 1
        CRTLine.append(cycle-1 >= x &&  cycle-1 <= x+2 ? "#" : ".")
        if (cycle) % 40 == 0 {
            CRT.append(String(CRTLine))
            CRTLine = ""
            cycle = 0
        }
        if split[0].contains("addx") {
            cycle += 1
            CRTLine.append(cycle-1 >= x &&  cycle-1 <= x+2 ? "#" : ".")
            x += Int(split[1])!
        }
        if cycle % 40 == 0 {
            CRT.append(String(CRTLine))
            CRTLine = ""
            cycle = 0
        }
    }
    for line in CRT {
        print(line)
    }
}











/*
 if sprite[cycle] == "#" {
     CRT.append("#")
 } else {
     CRT.append(".")
 }
 if split[0].contains("addx") {
     sprite[x] = "."
     sprite[x+1] = "."
     sprite[x+2] = "."
     x += Int(split[1])!
     sprite[x] = "#"
     sprite[x+1] = "#"
     sprite[x+2] = "#"
     //cycle += 1
 }
 print(cycle, x)
 if (cycle) % 40 == 0 {
     print("reset")
     print(CRT)
     print(sprite)
     CRT = []
     //x = 0
 }
 //print(sprite)
}
 */
