//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Vagner Oliveira on 5/5/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var outputLabel: UILabel!
	private var calculator = Calculator()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		CalculatorButton.setup()
		outputLabel.text = "0"
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func numberPressed(_ sender: CalculatorButton) {
		sender.playSound()
		calculator.addNumber("\(sender.tag)")
		outputLabel.text = calculator.runningNumber
	}
	
	/**
	* In this case, each operator button has its own corresponding tag
	* "+" -> 10
	* "-" -> 11
	* "*" -> 12
	* "/" -> 13
	*/
	@IBAction func operatorPressed(_ sender: CalculatorButton) {
		var operation = Calculator.Operation.Empty
		
		sender.playSound()
		switch sender.tag {
		case 10:
			operation = Calculator.Operation.Add
		case 11:
			operation = Calculator.Operation.Subtract
		case 12:
			operation = Calculator.Operation.Multiply
		case 13:
			operation = Calculator.Operation.Divide
		default:
			operation = calculator.currentOperation
		}
		calculator.performOperation(operation)
		outputLabel.text = calculator.result
	}

	@IBAction func clearPressed(_ sender: Any) {
		calculator.clear()
		outputLabel.text = "0"
	}
}

