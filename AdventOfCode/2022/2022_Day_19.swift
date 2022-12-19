//
//  2022_Day_19.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 19/12/2022.
//

import Foundation

private final class Blueprint: Decodable {
    var id: Int
    var instructions:[[Int]]
    
    init(id: Int, instructions: [[Int]]) {
        self.id = id
        self.instructions = instructions
    }
}

enum Soil: Int {
    case ore = 0, clay, obsidian, geode
    
    var description : Int {
        switch self {
        case .ore: return 0
        case .clay: return 1
        case .obsidian: return 2
        case .geode: return 3
        }
    }
}

func Day19_2022() {
    print("ℹ️ Day 19")
    
    var lines:[String.SubSequence] = []

    let file = URL(filePath: "Resources/2022_Day_19.txt")

    do {
        var contents = try String(contentsOf: file, encoding: String.Encoding.utf8 )
        contents = contents.replacingOccurrences(of: ": ", with: ".\n  ")
        contents = contents.replacingOccurrences(of: ". ", with: ".\n  ")
        contents = contents.replacingOccurrences(of: "\n\n", with: "\nblock\n")
        

        lines = contents.split(separator:"\n")
    } catch {
        fatalError("error")
    }
    
    let input = lines.map { String($0)}
    
    var blueprints:[Blueprint] = []

    var id = 0
    var robot = [[0,0,0], [0,0,0], [0,0,0], [0,0,0]]
    for line in input {
        if line.contains("Blueprint") {
            id = Int(line.components(separatedBy: " ")[1].alphanumeric)!
        }
        else if !line.contains("block") {
            let robotStyle = String(line.components(separatedBy: " robot")[0].components(separatedBy: "  Each ")[1])
            let split = line.components(separatedBy: "costs ")
            let res = split[1].components(separatedBy: " and ")
            for part in res {
                let partSplit = part.components(separatedBy: " ")
                let number = Int(partSplit[0])!
                let stuff = String(partSplit[1].alphanumeric)
                robot[getRobotPosition(for: robotStyle)][getSoilPosition(for: stuff)] = number
            }
        }
        
        if line.contains("Each geode robot costs") {
            blueprints.append(Blueprint(id: id, instructions: robot))
            robot = [[0,0,0], [0,0,0], [0,0,0], [0,0,0]]
        }
    }
    print(Part_1(blueprints: blueprints))
    print(Part_2(blueprints: blueprints))
}

private func Part_1(blueprints: [Blueprint]) -> Int {
    let MAXTIME = 24
    var resultArray:[Int] = []
    for blueprint in blueprints {
        var tryArray:[Int] = []
        for _ in 0..<99999 {
            tryArray.append(buildRobot(blueprint: blueprint, MAXTIME: MAXTIME))
        }
        print(tryArray.max()!)
        resultArray.append(tryArray.max()!)
    }
    
    let result = resultArray.enumerated().map { (index, element) in
        return (index+1)*element
    }.reduce(0, +)
    
    return result
}

private func Part_2(blueprints: [Blueprint]) -> Int {
    let MAXTIME = 32
    var resultArray:[Int] = []
    for j in 0..<3 { //3 {
            var tryArray:[Int] = []
            for _ in 0..<9999999 {
                tryArray.append(buildRobot(blueprint: blueprints[j], MAXTIME: MAXTIME))
            }
            resultArray.append(tryArray.max()!)
        }
    
    return resultArray.reduce(1, *)
}

private func buildRobot(blueprint: Blueprint, MAXTIME: Int) -> Int {
    var ore = 0, clay = 0, obsidian = 0, geode = 0
    var robotCounts = [1, 0, 0, 0]
    for _ in 1...MAXTIME {
        let rnd = Double.random(in: 0..<1.0)

        var roboType = " " // only set if buidling
        // can i buy a new robot?
        // geode robot
        if ore >= getCost(for: "geode", which: "ore", from: blueprint) &&
            obsidian >= getCost(for: "geode", which: "obsidian", from: blueprint) {
            
            roboType = "geode"
            ore -= getCost(for: "geode", which: "ore", from: blueprint)
            obsidian -= getCost(for: "geode", which: "obsidian", from: blueprint)
        }
        
        else if rnd <= 0.3 && ore >= getCost(for: "ore", which: "ore", from: blueprint) {
            ore -= getCost(for: "ore", which: "ore", from: blueprint)
            roboType = "ore"
        }
            
        // obsidian
        else if rnd <= 0.7 && ore >= getCost(for: "obsidian", which: "ore", from: blueprint) &&
                    clay >= getCost(for: "obsidian", which: "clay", from: blueprint)  {
            
            roboType = "obsidian"
            ore -= blueprint.instructions[getRobotPosition(for: "obsidian")][getSoilPosition(for: "ore")]
            clay -= blueprint.instructions[getRobotPosition(for: "obsidian")][getSoilPosition(for: "clay")]
        }
        // clay
        else if rnd <= 0.9 && ore >= getCost(for: "clay", which: "ore", from: blueprint) {
            
            roboType = "clay"
            ore -= blueprint.instructions[getRobotPosition(for: "clay")][getSoilPosition(for: "ore")]
        }
        
        ore += robotCounts[getRobotPosition(for: "ore")]
        clay += robotCounts[getRobotPosition(for: "clay")]
        obsidian += robotCounts[getRobotPosition(for: "obsidian")]
        geode += robotCounts[getRobotPosition(for: "geode")]
        
        if roboType != " " {
            robotCounts[getRobotPosition(for: roboType)] += 1
            roboType = " "
        }
    }
    return geode
}

private func getCost(for robot: String, which soil: String, from blueprint: Blueprint) -> Int {
    return blueprint.instructions[getRobotPosition(for: robot)][getSoilPosition(for: soil)]
}


private func getSoilPosition(for soil: String) -> Int {
    switch soil {
    case "ore": return 0
    case "clay": return 1
    case "obsidian": return 2
    case "geode": return 3
    default: return 99
    }
}

private func getRobotPosition(for robot: String) -> Int {
    switch robot {
    case "ore": return 0
    case "clay": return 1
    case "obsidian": return 2
    case "geode": return 3
    default: return 99
    }
}
