//
//  readFile.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 30/11/2022.
//

import Foundation
import CoreLocation

func readFile(filename: String) -> [String.SubSequence] {
    var lines:[String.SubSequence] = []

    let file = URL(filePath: filename)

    do {
        var contents = try String(contentsOf: file, encoding: String.Encoding.utf8 )
        
        contents = contents.replacingOccurrences(of: "\n\n", with: "\nblock\n")
        

        lines = contents.split(separator:"\n")
    } catch {
        fatalError("error")
    }
    
    return lines
}
