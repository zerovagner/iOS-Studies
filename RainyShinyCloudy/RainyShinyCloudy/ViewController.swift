//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Vagner Oliveira on 5/12/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import Alamofire

typealias DownloadComplete = () -> ()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var weatherImage: UIImageView!
	@IBOutlet weak var tableView: UITableView!
	
	var currentWeather: Weather!
	var forecast = [Weather]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		currentWeather = Weather()
		tableView.dataSource = self
		tableView.delegate = self
		currentWeather.downloadCurrentWeatherData {
			self.downloadForecastWeatherData {
				self.updateCurrentWeather()
			}
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
		return forecast.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let tableCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell {
			tableCell.setUp(fromWeather: forecast[indexPath.row])
			return tableCell
		} else {
			return WeatherTableViewCell()
		}
	}
	
	func updateCurrentWeather() {
		dateLabel.text = currentWeather.date
		temperatureLabel.text = currentWeather.currentTemperature
		cityLabel.text = currentWeather.cityName
		weatherLabel.text = currentWeather.currentWeather
		weatherImage.image = UIImage(named: currentWeather.currentWeather)
	}
	
	func downloadForecastWeatherData(completed: @escaping DownloadComplete) {
		Alamofire.request(Weather.forecastUrl, parameters: Weather.params).responseJSON { response in
			let result = response.result
			if let dict = result.value as? [String:Any] {
				if let list = dict["list"] as? [[String:Any]] {
					for obj in list {
						let weather = Weather(obj: obj)
						self.forecast.append(weather)
					}
					self.tableView.reloadData()
				}
			}
		}
		completed()
	}
}

