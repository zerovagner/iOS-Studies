//
//  ViewController.swift
//  MiraclePills
//
//  Created by Vagner Oliveira on 4/26/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

	@IBOutlet weak var countryPicker: UIPickerView!
	@IBOutlet weak var countryButton: UIButton!
	@IBOutlet weak var statePicker: UIPickerView!
	@IBOutlet weak var stateButton: UIButton!
	
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var zipCodeLabel: UILabel!
	@IBOutlet weak var zipCodeTextField: UITextField!
	
	let states = ["Alaska", "Arizona", "California", "New York", "New Jersey", "Oregon", "Washignton"]
	let countries = ["Argentina", "Brazil", "Canada", "England", "United States"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		statePicker.delegate = self
		statePicker.dataSource = self
		countryPicker.delegate = self
		countryPicker.dataSource = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func stateButtonPressed(_ sender: UIButton) {
		statePicker.isHidden = false
		
		countryLabel.isHidden = true
		countryButton.isHidden = true
		countryPicker.isHidden = true
		zipCodeTextField.isHidden = true
		zipCodeLabel.isHidden = true
	}

	@IBAction func countryButtonPressed(_ sender: UIButton) {
		countryPicker.isHidden = false
		
		statePicker.isHidden = true
		zipCodeLabel.isHidden = true
		zipCodeTextField.isHidden = true
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == statePicker {
			return states.count
		} else {
			return countries.count
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == statePicker {
			return states[row]
		} else {
			return countries[row]
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if pickerView == statePicker {
			stateButton.setTitle(states[row], for: UIControlState.normal)
			statePicker.isHidden = true
			
			countryLabel.isHidden = false
			countryButton.isHidden = false
			zipCodeTextField.isHidden = false
			zipCodeLabel.isHidden = false
		}
		if pickerView == countryPicker {
			countryButton.setTitle(countries[row], for: UIControlState.normal)
			countryPicker.isHidden = true
		
			zipCodeLabel.isHidden = false
			zipCodeTextField.isHidden = false
		}
	}
}

