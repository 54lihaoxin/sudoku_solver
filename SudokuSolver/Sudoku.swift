//
//  Sudoku.swift
//  SudokuSolver
//
//  Created by Haoxin Li on 8/29/18.
//  Copyright © 2018 Haoxin Li. All rights reserved.
//

import Foundation

final class Sudoku {
    
    typealias Layout = [[Value]]
    
    private let originalLayout: Layout
    private var currentLayout: Layout
    
    init(_ strings: [String]) {
        let layout: Layout = strings.reduce(Layout()) { (partialResult, rowString) in
            partialResult + [rowString.map { Value(stringLiteral: "\($0)") }]
        }
        guard layout.count == 9 else {
            fatalError("\(#function) invalid layout format")
        }
        layout.forEach {
            guard $0.count == 9 else {
                fatalError("\(#function) invalid layout format")
            }
        }
        originalLayout = layout
        currentLayout = layout
    }
}

// MARK: - Sudoku.Value

extension Sudoku {
    
    enum Value: Int, ExpressibleByStringLiteral, ExpressibleByIntegerLiteral, CustomStringConvertible {
        
        typealias StringLiteralType = String
        typealias IntegerLiteralType = Int
        
        case empty
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        
        static let allNoneEmptyCases = [one, two, three, four, five, six, seven, eight, nine]
        static let allCases = [empty] + Value.allNoneEmptyCases
        
        init(stringLiteral value: String) {
            if value == Value.empty.description {
                self = .empty
            } else { // case 1 ~ 9
                guard let intValue = Int(value) else {
                    fatalError("\(#function) unexpected value \(value)")
                }
                self.init(integerLiteral: intValue)
            }
        }
        
        init(integerLiteral value: Int) {
            guard let v = Value(rawValue: value) else {
                fatalError("\(#function) unexpected value \(value)")
            }
            self = v
        }
        
        var description: String {
            switch self {
            case .empty:
                return "_"
            default:
                return "\(rawValue)"
            }
        }
    }
}

// MARK: - Sudoku: CustomStringConvertible

extension Sudoku: CustomStringConvertible {
    
    var description: String {
        return "\(currentLayout)" // TODO
    }
}
