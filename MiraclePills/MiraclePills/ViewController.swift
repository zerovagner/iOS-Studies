//
//  ViewController.swift
//  MiraclePills
//
//  Created by Vagner Oliveira on 4/26/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	@IBOutlet weak var pillImage: UIImageView!
	@IBOutlet weak var pillLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var divider: UIView!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var cityTextField: UITextField!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var stateLabel: UILabel!
	
	@IBOutlet weak var countryPicker: UIPickerView!
	@IBOutlet weak var countryButton: UIButton!
	@IBOutlet weak var statePicker: UIPickerView!
	@IBOutlet weak var stateButton: UIButton!
	
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var zipCodeLabel: UILabel!
	@IBOutlet weak var zipCodeTextField: UITextField!
	
	@IBOutlet weak var successSign: UIImageView!
	@IBOutlet weak var buyNowButton: UIButton!
	
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
		buyNowButton.isHidden = true
	}

	@IBAction func buyNowButtonPressed(_ sender: Any) {
		/* There are three options on hiding all the elements when the BUY NOW button is pressed:
			- hide all elements one by one and unhide the success sign
			- create a new view covering the current, containing only the sign
			- navigate to a new view containing the success sign
		
			I chose the first option to keep the solution in a single view
		*/
		pillImage.isHidden = true
		pillLabel.isHidden = true
		priceLabel.isHidden = true
		divider.isHidden = true
		nameLabel.isHidden = true
		nameTextField.isHidden = true
		addressLabel.isHidden = true
		addressTextField.isHidden = true
		cityLabel.isHidden = true
		cityTextField.isHidden = true
		stateLabel.isHidden = true
		statePicker.isHidden = true
		stateButton.isHidden = true
		countryButton.isHidden = true
		countryLabel.isHidden = true
		countryPicker.isHidden = true
		zipCodeTextField.isHidden = true
		zipCodeLabel.isHidden = true
		buyNowButton.isHidden = true
		
		successSign.isHidden = false
	}
	@IBAction func countryButtonPressed(_ sender: UIButton) {
		countryPicker.isHidden = false
		
		statePicker.isHidden = true
		zipCodeLabel.isHidden = true
		zipCodeTextField.isHidden = true
		buyNowButton.isHidden = true
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
		}
		if pickerView == countryPicker {
			countryButton.setTitle(countries[row], for: UIControlState.normal)
			countryPicker.isHidden = true
		}
		zipCodeTextField.isHidden = false
		zipCodeLabel.isHidden = false
		buyNowButton.isHidden = false
	}
}

