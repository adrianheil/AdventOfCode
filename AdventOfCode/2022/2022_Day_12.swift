//
//  2022_Day_12.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 12/12/2022.
//

import Foundation

func Day12_2022() {
    print("ℹ️ Day 12")
    let input = readFile(filename: "Resources/2022_Day_12.txt").map { String($0)}
    
    Part_1(input: input)
}

private func Part_1(input: [String]) {
    var startX = 0, startY = 0, endX = 0, endY = 0
    var dist = [[Int]](repeating: [Int](repeating: 9999, count: input[0].count+2), count: input.count+2)
    var map = [[Int]](repeating: [Int](repeating: -50, count: input[0].count+2), count: input.count+2)
    // start at 1, create a border around the actual map to avoid out of bounds error
    for y in 0..<input.count {
        for x in 0..<input[y].count {
            if input[y][x] == "S" {
                map[y+1][x+1]=1;
                startX=y+1;
                startY=x+1;
            }
            else if(input[y][x] == "E") {
                map[y+1][x+1]=26
                endX=y+1
                endY=x+1
            }
            else {
                map[y+1][x+1] = Int(input[y][x].asciiValue! - 96)
            }
        }
    }
    dist[endX][endY] = 0
    getDistance(x: endX,y: endY, dist: &dist, map: &map)
    //Part 1
    print(dist[startX][startY])
    // Part 2
    var distances:[Int] = []
    for i in 1..<map.count {
        for j in 1..<map[0].count {
            if map[i][j] == 1 {
                distances.append(dist[i][j])
            }
        }
    }
    print(distances.min()!)
}

func getDistance(x: Int, y: Int, dist: inout [[Int]], map: inout [[Int]]) {
    if map[x-1][y]+1 >= map[x][y] && dist[x-1][y] > dist[x][y]+1 {
        dist[x-1][y] = dist[x][y]+1
        getDistance(x: x-1,y: y, dist: &dist, map: &map)
    }
    if map[x+1][y]+1 >= map[x][y] && dist[x+1][y] > dist[x][y]+1 {
        dist[x+1][y] = dist[x][y]+1
        getDistance(x: x+1,y: y, dist: &dist, map: &map)
        
    }
    if map[x][y-1]+1 >= map[x][y] && dist[x][y-1] > dist[x][y]+1 {
        dist[x][y-1] = dist[x][y]+1
        getDistance(x: x,y: y-1, dist: &dist, map: &map)
    }
    if map[x][y+1]+1 >= map[x][y] && dist[x][y+1] > dist[x][y]+1 {
        dist[x][y+1] = dist[x][y]+1
        getDistance(x: x,y: y+1, dist: &dist, map: &map)
    }


}




