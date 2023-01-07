//
//  StructsEnums.swift
//  Calculator
//
//  Created by Dzjem Gard on 2023-01-02.
//

import Foundation

enum Operator: String {
    case add = "+"
    case subtract = "-"
    case times = "*"
    case divide = "/"
    case nothing = ""
}

enum CalculationState: String {
    case enteringNumber = "enteringNum"
    case newNumStarted = "newNumStarted"
    
}
