//
//  Result_2022.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 01/12/2022.
//

import Foundation


func result_2022() {
    //let file = readFile(filename: "/Users/adrian/Documents/Code/Swift/AdventOfCode/AdventOfCode/Resources/2022_Day_1.txt")
    var file = readFile(filename: "Resources/2022_Day_1.txt")
    Day01_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_2.txt")
    Day02_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_3.txt")
    Day03_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_4.txt")
    Day04_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_5.txt")
    Day05_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_6.txt")
    Day06_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_7.txt")
    Day07_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_8.txt")
    Day08_2022(data: file)
    
    file = readFile(filename: "Resources/2022_Day_9.txt")
    Day09_2022(data: file)
}
