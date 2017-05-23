//
//  Weather.swift
//  RainyShinyCloudy
//
//  Created by Vagner Oliveira on 5/15/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class Weather {
	private(set) var cityName: String!
	private(set) var currentWeather: String!
	private var currentDate: String!
	private(set) var currentTemperature: String!
	private(set) var maxTemperature: String!
	private(set) var minTemperature: String!
	
	static let baseUrl = "http://api.openweathermap.org/data/2.5/"
	static let params = [
		"lat":"\(lat)",
		"lon":"\(lon)",
		"appid":"42a1771a0b787bf12e734ada0cfc80cb"
	]
	private static var lat = 0.0
	private static var lon = 0.0
	
	static let forecastUrl = baseUrl + "forecast/daily"
	
	var date: String! {
		get {
			if currentDate == "" {
				let df = DateFormatter()
				df.dateStyle = .long
				df.timeStyle = .none
				currentDate = df.string(from: Date())
			}
			return currentDate
		}
	}
	
	init() {
		cityName = ""
		currentWeather = ""
		currentDate = ""
		currentTemperature = ""
		minTemperature = ""
		maxTemperature = ""
	}
	
	init(obj: [String:Any]) {
		if let temp = obj["temp"] as? [String:Any] {
			if let min = temp["min"] as? Double {
				minTemperature = "\(round(10 * (min - 273))/10)º"
			}
			if let max = temp["max"] as? Double {
				maxTemperature = "\(round(10 * (max - 273))/10)º"
			}
		}
		if let weather = obj["weather"] as? [[String:Any]] {
			if let main = weather[0]["main"] as? String {
				currentWeather = main.capitalized
			}
		}
		if let date = obj["dt"] as? Double {
			let convertedDate = Date(timeIntervalSince1970: date)
			let dateFormatter = DateFormatter()
			dateFormatter.dateStyle = .full
			dateFormatter.dateFormat = "EEEE"
			dateFormatter.timeStyle = .none
			let dateIndex = Calendar.current.component(.weekday, from: convertedDate)
			currentDate = dateFormatter.weekdaySymbols[dateIndex-1]
		}
	}
	
	func setUp (fromJSON dict: [String:Any]) {
		if let name = dict["name"] as? String {
			cityName = name.capitalized
			print(cityName)
		}
		if let weather = dict["weather"] as? [[String:Any]] {
			if let curWeather = weather[0]["main"] as? String {
				currentWeather = curWeather.capitalized
				print(currentWeather)
			}
		}
		if let main = dict["main"] as? [String:Any] {
			if let temp = main["temp"] as? Double {
				currentTemperature = "\(round(10 * (temp - 273))/10)º"
				print(currentTemperature)
			}
		}
	}
	
	func downloadCurrentWeatherData (completed: @escaping DownloadComplete) {
		let currentWeatherUrl = Weather.baseUrl + "weather"
		Alamofire.request(currentWeatherUrl, parameters: Weather.params).responseJSON { response in
			let result = response.result
			if let dict = result.value as? [String:Any] {
				self.setUp(fromJSON: dict)
			}
			completed()
		}
	}
	
	static func setCoordinates(fromLocation location: CLLocation) {
		lat = round(100 * location.coordinate.latitude)/100
		lon = round(100 * location.coordinate.longitude)/100
		print("lat: \(lat) lon: \(lon)")
	}
}
