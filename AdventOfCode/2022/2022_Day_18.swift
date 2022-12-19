//
//  2022_Day_18.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 18/12/2022.
//

import Foundation

struct Coord: Hashable, Equatable {
    let x: Int
    let y: Int
    let z: Int
}

func Day18_2022 () {
    let input = readFile(filename: "Resources/2022_Day_18.txt").map { String($0)}
    let cubes = input.compactMap { line in
        let split = line.components(separatedBy: ",")
        return Coord(x: Int(split[0])!, y: Int(split[1])!, z: Int(split[2])!)
    }
    
    print(Part_1(cubes: cubes))
    print(Part_2(cubes: cubes))
}



private func Part_1(cubes: [Coord]) -> Int {
    var surface = 0
    var coordDict = [Coord: Bool]()
    cubes.forEach { coord in
        coordDict[coord] = true
    }
    
    for cube in cubes {
        if coordDict[Coord(x: cube.x + 1, y: cube.y, z: cube.z), default: false] == false {
            surface += 1
        }
        if coordDict[Coord(x: cube.x - 1, y: cube.y, z: cube.z), default: false] == false {
            surface += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y + 1, z: cube.z), default: false] == false {
            surface += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y - 1, z: cube.z), default: false] == false {
            surface += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y, z: cube.z + 1), default: false] == false {
            surface += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y, z: cube.z - 1), default: false] == false {
            surface += 1
        }
    }
    
    return surface
}

private func Part_2(cubes: [Coord]) -> Int {
    var coordDict = [Coord: Bool]()
    cubes.forEach { coord in
        coordDict[coord] = true
    }
    
    var queue = [Coord(x: 0, y: 0, z: 0)]
    while !queue.isEmpty {
        expand(from: queue.removeLast(), store: &coordDict, queue: &queue)
    }
    
    var surfaceArea = 0
    for cube in cubes {
        if coordDict[Coord(x: cube.x + 1, y: cube.y, z: cube.z)] == false {
            surfaceArea += 1
        }
        if coordDict[Coord(x: cube.x - 1, y: cube.y, z: cube.z)] == false {
            surfaceArea += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y + 1, z: cube.z)] == false {
            surfaceArea += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y - 1, z: cube.z)] == false {
            surfaceArea += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y, z: cube.z + 1)] == false {
            surfaceArea += 1
        }
        if coordDict[Coord(x: cube.x, y: cube.y, z: cube.z - 1)] == false {
            surfaceArea += 1
        }
    }
    
    return surfaceArea
}

func expand(from: Coord, store: inout [Coord: Bool], queue: inout [Coord]) {
    if from.x < -2 || from.x > 25 { return }
    if from.y < -2 || from.y > 25 { return }
    if from.z < -2 || from.z > 25 { return }
    if store[Coord(x: from.x, y: from.y, z: from.z + 1)] == nil {
        queue.append(Coord(x: from.x, y: from.y, z: from.z + 1))
        store[Coord(x: from.x, y: from.y, z: from.z + 1)] = false
    }
    if store[Coord(x: from.x, y: from.y, z: from.z - 1)] == nil {
        queue.append(Coord(x: from.x, y: from.y, z: from.z - 1))
        store[Coord(x: from.x, y: from.y, z: from.z - 1)] = false
    }
    if store[Coord(x: from.x, y: from.y + 1, z: from.z)] == nil {
        queue.append(Coord(x: from.x, y: from.y + 1, z: from.z))
        store[Coord(x: from.x, y: from.y + 1, z: from.z)] = false
    }
    if store[Coord(x: from.x, y: from.y - 1, z: from.z)] == nil {
        queue.append(Coord(x: from.x, y: from.y - 1, z: from.z))
        store[Coord(x: from.x, y: from.y - 1, z: from.z)] = false
    }
    if store[Coord(x: from.x + 1, y: from.y, z: from.z)] == nil {
        queue.append(Coord(x: from.x + 1, y: from.y, z: from.z))
        store[Coord(x: from.x + 1, y: from.y, z: from.z)] = false
    }
    if store[Coord(x: from.x - 1, y: from.y, z: from.z)] == nil {
        queue.append(Coord(x: from.x - 1, y: from.y, z: from.z))
        store[Coord(x: from.x - 1, y: from.y, z: from.z)] = false
    }
}
