//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Vagner Oliveira on 5/12/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

typealias DownloadComplete = () -> ()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var weatherImage: UIImageView!
	@IBOutlet weak var tableView: UITableView!
	
	var currentWeather = Weather()
	var forecast = [Weather]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		currentWeather.downloadCurrentWeatherData {
			self.updateCurrentWeather()
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tableCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
		return tableCell
	}
	
	func updateCurrentWeather() {
		dateLabel.text = currentWeather.date
		temperatureLabel.text = currentWeather.currentTemperature
		cityLabel.text = currentWeather.cityName
		weatherLabel.text = currentWeather.currentWeather
		weatherImage.image = UIImage(named: currentWeather.currentWeather)
	}
}

