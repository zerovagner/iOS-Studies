//
//  ViewController.swift
//  MiraclePills
//
//  Created by Vagner Oliveira on 4/26/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var statePicker: UIPickerView!
	@IBOutlet weak var stateButton: UIButton!
	
	let states = ["Alaska", "Arizona", "California", "New York", "New Jersey", "Oregon", "Washignton"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		statePicker.delegate = self
		statePicker.dataSource = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func stateButtonPressed(_ sender: UIButton) {
		statePicker.isHidden = false
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return states.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return states[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		stateButton.setTitle(states[row], for: UIControlState.normal)
		statePicker.isHidden = true
	}
}

