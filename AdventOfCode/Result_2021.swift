//
//  Result_2021.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 01/12/2022.
//

import Foundation

func Result_2021() {
    var file = readFile(filename: "Resources/2021_Day_1.txt")
    Day01_2021(data: file)
    
    file = readFile(filename: "Resources/2021_Day_2.txt")
    Day02_2021(data: file)
    
    file = readFile(filename: "Resources/2021_Day_3.txt")
    Day03_2021(data: file)
}
