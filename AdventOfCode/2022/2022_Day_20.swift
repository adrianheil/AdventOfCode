//
//  2022_Day_20.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 20/12/2022.
//

import Foundation

func Day20_2022() {
    print("ℹ️ Day 20")
    let input = readFile(filename: "Resources/2022_Day_20.txt").compactMap { Int($0)}
    
    decrypt(input: input, n: 1)
    
    decrypt(input: input.map{$0*811589153}, n: 10)
}

private func decrypt(input: [Int], n: Int) {
    
    let l = input.count
    var inputIndex = Array(0..<l)
    for _ in 0..<n {
        for (i, element) in input.enumerated() {
            if element == 0 {
                continue
            }
            let currentPos = inputIndex.firstIndex(of: i)!
            let x = inputIndex.remove(at: currentPos)
            var nextPos = (currentPos + element) %% (l - 1)
            if nextPos == 0 && element < 0 { nextPos = l-1 }
            else if nextPos == l-1 && element > 0 { nextPos = 0 }
            inputIndex.insert(x, at: nextPos)
        }
    }
    
    printIndexPositions(node: inputIndex.map { i in
        return input[i]        
    })

}

private func printIndexPositions(node: [Int]) {
    let zeroIndex = node.firstIndex(of: 0)!
    print(zeroIndex)
    print(node[(zeroIndex+1000) %% (node.count)] +
          node[(zeroIndex+2000) %% (node.count)] +
          node[(zeroIndex+3000) %% (node.count)])
}
