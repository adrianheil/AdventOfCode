//
//  2022_Day_13.swift
//  AdventOfCode
//
//  Created by Adrian Heil on 13/12/2022.
//

import Foundation

enum Message: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral, Decodable, Comparable {
    case value(Int)
    indirect case list([Message])

    init(integerLiteral: Int) {
        self = .value(integerLiteral)
    }
    init(arrayLiteral: Self...) {
        self = .list(arrayLiteral)
    }
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self = .value(try container.decode(Int.self))
        } catch {
            self = .list(try [Message](from: decoder))
        }
    }
    static func < (l: Self, r: Self) -> Bool {
        switch (l, r) {
        case (.value(let l), .value(let r)): return l < r
        case (.value(_), .list(_)): return .list([l]) < r
        case (.list(_), .value(_)): return l < .list([r])
        case (.list(let l), .list(let r)):
            for (l, r) in zip(l, r) {
                if l < r { return true }
                if l > r { return false }
            }
            return l.count < r.count
        }
    }
}

func Day13_2022 () {
    let input = readFile(filename: "Resources/2022_Day_13.txt").map { String($0)}

    var messages:[Message] = []
    
    for line in input {
        if line == "block" { continue }
        let message: Message = try! JSONDecoder().decode(
            Message.self,
            from: line.data(using: .utf8)!
        )
        messages.append(message)
    }
    var countRightOrder = 0
    for i in stride(from: 0, to: messages.count, by: 2) {
        if messages[i] < messages[i+1] {
            countRightOrder += i/2+1
        }
    }
    //Part 1
    print(countRightOrder)
    //Part 2
    let divider2: Message = [[2]]
    let divider6: Message = [[6]]

    var messagesWithDivider: [Message] = messages + [divider2, divider6]
    messagesWithDivider.sort()

    let index2 = messagesWithDivider.firstIndex(of: divider2)!
    let index6 = messagesWithDivider.firstIndex(of: divider6)!
    print((index2+1) * (index6+1))
}


