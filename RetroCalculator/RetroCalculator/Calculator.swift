//
//  Calculator.swift
//  RetroCalculator
//
//  Created by Vagner Oliveira on 5/8/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation

struct Calculator {
	enum Operation: String {
		case Add = "+"
		case Subtract = "-"
		case Multiply = "*"
		case Divide = "/"
		case Empty = ""
	}
	
	private(set) var currentOperation = Operation.Empty
	private(set) var runningNumber = ""
	private var leftOperand = ""
	private var rightOperand = ""
	private(set) var result = ""
	
	mutating func addNumber(_ number: String) {
		runningNumber += number
	}
	
	mutating func performOperation(_ operation: Operation) {
		if currentOperation != .Empty {
			if runningNumber != "" {
				rightOperand = runningNumber
				runningNumber = ""
				
				if operation == .Multiply {
					result = "\(Int(leftOperand)! * Int(rightOperand)!)"
				} else if operation == .Divide {
					if rightOperand == "0" {
						result = "ERROR"
						return
					}
					result = "\(Int(leftOperand)! / Int(rightOperand)!)"
				} else if operation == .Subtract {
					result = "\(Int(leftOperand)! - Int(rightOperand)!)"
				} else if operation == .Add {
					result = "\(Int(leftOperand)! + Int(rightOperand)!)"
				}
				leftOperand = result
			}
			currentOperation = operation
		} else {
			leftOperand = runningNumber
			result = "0"
			runningNumber = ""
			currentOperation = operation
		}
	}
}
