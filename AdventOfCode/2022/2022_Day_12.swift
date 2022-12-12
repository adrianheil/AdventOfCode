//
//  2022_Day_12.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 12/12/2022.
//

import Foundation

var map = [[Int]](repeating: [Int](repeating: -50, count: 150), count: 150)
var dist = [[Int]](repeating: [Int](repeating: 9999, count: 150), count: 150)

func Day12_2022() {
    print("ℹ️ Day 12")
    let input = readFile(filename: "Resources/2022_Day_12.txt").map { String($0)}
    
    
    print(Part_1(input: input))
    //print(Throw(input: input, iterations: 10000, numberOfMonkeys: numberOfMonkeys))
}

private func Part_1(input: [String]) {
    var sx = 0, sy = 0, ex = 0, ey = 0
    // start at 1, create a border around the actual map to avoid out of bounds error
    for y in 0..<input.count {
        for x in 0..<input[y].count {
            if input[y][x] == "S" {
                map[y+1][x+1]=1;
                sx=y+1;
                sy=x+1;
            }
            else if(input[y][x] == "E") {
                map[y+1][x+1]=26
                ex=y+1
                ey=x+1
            }
            else {
                map[y+1][x+1] = Int(input[y][x].asciiValue! - 96)
            }
        }
    }
    dist[ex][ey] = 0
    getDistance(x: ex,y: ey)

    print(dist[sx][sy])
}

func getDistance(x: Int, y: Int) {
    if (map[x-1][y]+1 >= map[x][y]) && (dist[x-1][y] > dist[x][y]+1) {
        dist[x-1][y] = dist[x][y]+1
        getDistance(x: x-1,y: y)
    }
    if (map[x+1][y]+1 >= map[x][y]) && (dist[x+1][y] > dist[x][y]+1) {
        dist[x+1][y] = dist[x][y]+1
        getDistance(x: x+1,y: y)
        
    }
    if (map[x][y-1]+1 >= map[x][y]) && (dist[x][y-1] > dist[x][y]+1) {
        dist[x][y-1] = dist[x][y]+1
        getDistance(x: x,y: y-1)
    }
    if (map[x][y+1]+1 >= map[x][y]) && (dist[x][y+1] > dist[x][y]+1) {
        dist[x][y+1] = dist[x][y]+1
        getDistance(x: x,y: y+1)
    }


}




