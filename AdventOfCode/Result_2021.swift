//
//  Result_2021.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 01/12/2022.
//

import Foundation

func Result_2021() {
    let file = readFile(filename: "Resources/2021_Day_1.txt")
    let result = countIncreases(data: file)
    print(result)
}
