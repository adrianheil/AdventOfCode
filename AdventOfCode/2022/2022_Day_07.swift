//
//  2022_Day_07.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 06/12/2022.
//

import Foundation

func Day07_2022(data: [String.SubSequence]) {
    print("ℹ️ Day 7")
    let input = data.map { String($0)}

    var wd = ""
    var fileStructure = [String: Int]()
    for line in input {
        if line.contains("cd ..") {
            //print(pwd)
            let index = wd.range(of: "/", options: .backwards)?.lowerBound
            wd = String(wd[..<index!])
        }
        else if line.contains("$ cd ") {
            wd = wd + "/" + line.components(separatedBy: " ")[2]
            fileStructure[wd] = 0
        }
        else if NSRegularExpression("^[0-9]* [a-zA-Z]").matches(line) {
            var path = wd
            while path != "" {
                fileStructure[path]! += Int(line.components(separatedBy: " ")[0])!
                let index = path.range(of: "/", options: .backwards)?.lowerBound
                if String(path[..<index!]).contains("//") {
                    path = String(path[..<index!])
                } else {
                    path = ""
                }
            }
        }
    }
    print(Part_1(fileStructure: fileStructure))
    print(Part_2(fileStructure: fileStructure))
 
}

private func Part_1(fileStructure: [String: Int]) -> Int {
    return fileStructure
        .filter { item in
            item.value <= 100000
        }
        .compactMap({ $0.value })
        .reduce(0, +)
}

private func Part_2(fileStructure: [String: Int]) -> Int {
    let freeMem = 70000000 - fileStructure["//"]!
    return fileStructure
        .filter{ item in
            item.value + freeMem >= 30000000
        }
        .compactMap {$0.value}
        .sorted(by: <)
        .first!
}
