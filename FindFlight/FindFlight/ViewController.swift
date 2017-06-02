//
//  ViewController.swift
//  FindFlight
//
//  Created by Vagner Oliveira on 3/14/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	let numberOfFlights: UInt = 500
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var barTitle: UINavigationItem!
	@IBOutlet weak var searchBar: UISearchBar!
	
	var flightList: [String] = []
	var sections: [String] = []
	var searchResults: [String] = []
	
	var isSearching: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		barTitle.title = "Flights"
		
		tableView.dataSource = self
		tableView.delegate = self
		searchBar.delegate = self
		
		flightList = generateFlightList(numberOfFlights: numberOfFlights)
		sections = generateSections(from: flightList)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isSearching {
			return searchResults.count
		}
		if sections.count > 1 {
			let filteredList = flightList.filter({$0.contains(sections[section])})
			return filteredList.count
		}
		return flightList.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		if isSearching {
			return 1
		} else {
			if sections.count > 1 {
				return sections.count
			} else {
				return 1
			}
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "flightCell")!
		if isSearching {
			cell.textLabel?.text = searchResults[indexPath.row]
		} else {
			if sections.count > 1 {
				let filteredList = flightList.filter({$0.contains(sections[indexPath.section])})
				cell.textLabel?.text = filteredList[indexPath.row]
			} else {
				if tableView.restorationIdentifier == "searchBar" {
					cell.textLabel?.text = searchResults[indexPath.row]
				} else {
					cell.textLabel?.text = flightList[indexPath.row]
				}
			}
		}
		return cell
	}
	
	func sectionIndexTitles(for tableView: UITableView) -> [String]? {
		if isSearching {
			return nil
		}
		return sections
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if isSearching {
			return nil
		}
		return sections[section]
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		var flight = ""
		if isSearching {
			flight = searchResults[indexPath.row]
		} else if sections.count > 1 {
			let filteredList = flightList.filter({$0.contains(sections[indexPath.section])})
			flight = filteredList[indexPath.row]
		} else {
			flight = flightList[indexPath.row]
		}
		let messsage = String("Company: \(sections[indexPath.section]) \n Flight: \(flight)")
		let alert = UIAlertController(title: "Flight List", message: messsage, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText != "" {
			isSearching = true
			searchResults = flightList.filter({$0.contains(searchText)})
		} else {
			isSearching = false
		}
		self.tableView.reloadData()
	}
	
	/**
	* Generates the sections array based on the flight list received.
	* Each section will be composed by the first sectionSize characters of the string.
	*/
	func generateSections (from list: [String]) -> [String] {
		let sectionSize: String.IndexDistance = 2
		
		var sections: [String] = []
		for element in list {
			let section = element.substring(to: element.index(element.startIndex, offsetBy: sectionSize))
			if !sections.contains(section) {
				sections.append(section)
			}
		}
		return sections
	}
}

/**
* Functions to generate the flight list made of random strings
*/
func generateFlightList (numberOfFlights: UInt) -> [String] {
	var list: [String] = []
	for _ in 0...numberOfFlights {
		list.append(generateFlight())
	}
	return list.sorted()
}

// Generates a random string in the format C(numOfChars) and I(numOfInts), where C is a character and I is a integer
func generateFlight() -> String {
	let numOfChars: Int = 2
	let numOfInts: Int = 4
	
	let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	let numbers = "1234567890"
	
	let letterCount = UInt32(letters.characters.count)
	let numberCount = UInt32(numbers.characters.count)
	
	var flight: String = ""
	
	for i in 0..<(numOfChars + numOfInts) {
		if i < numOfChars {
			flight += String(letters[letters.index(letters.startIndex, offsetBy: Int(arc4random_uniform(letterCount)))])
		} else {
			flight += String(numbers[numbers.index(numbers.startIndex, offsetBy: Int(arc4random_uniform(numberCount)))])
		}
	}
	return flight
}
