//
//  Weather.swift
//  RainyShinyCloudy
//
//  Created by Vagner Oliveira on 5/15/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class Weather {
	private(set) var cityName: String!
	private(set) var currentWeather: String!
	private var currentDate: String!
	private(set) var currentTemperature: String!
	private(set) var maxTemperature: Double!
	private(set) var minTemperature: Double!
	
	var date: String! {
		get {
			if currentDate != "" {
				let df = DateFormatter()
				df.dateStyle = .long
				df.timeStyle = .none
				currentDate = df.string(from: Date())
			}
			return currentDate
		}
	}
	
	func setUp (fromJSON dict: [String:Any]) {
		if let name = dict["name"] as? String {
			cityName = name.capitalized
		}
		if let weather = dict["weather"] as? [[String:Any]] {
			if let curWeather = weather[0]["main"] as? String {
				currentWeather = curWeather.capitalized
			}
		}
		if let main = dict["main"] as? [String:Any] {
			if let temp = main["temp"] as? Double {
				currentTemperature = "\(round(10 * (temp - 273)/10))º"
			}
		}
		print(cityName)
		print(currentWeather)
		print(currentTemperature)
	}
	
	func downloadCurrentWeatherData (completed: @escaping DownloadComplete) {
		let currentWeatherUrl = "http://api.openweathermap.org/data/2.5/weather"
		let params = [
			"lat":"35",
			"lon":"139",
			"appid":"42a1771a0b787bf12e734ada0cfc80cb"
		]
		Alamofire.request(currentWeatherUrl, parameters: params).responseJSON { response in
			let result = response.result
			if let dict = result.value as? [String:Any] {
				self.setUp(fromJSON: dict)
			}
			completed()
		}
	}
}
