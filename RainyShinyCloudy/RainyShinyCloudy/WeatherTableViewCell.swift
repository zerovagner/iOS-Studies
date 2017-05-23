//
//  WeatherTableViewCell.swift
//  RainyShinyCloudy
//
//  Created by Vagner Oliveira on 5/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

	@IBOutlet weak var weatherIcon: UIImageView!
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var weatherLabel: UILabel!
	@IBOutlet weak var maxTempLabel: UILabel!
	@IBOutlet weak var minTempLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setUp (fromWeather weather: Weather) {
		weatherIcon.image = UIImage(named: weather.currentWeather + " Mini")
		maxTempLabel.text = weather.maxTemperature
		minTempLabel.text = weather.minTemperature
		weatherLabel.text = weather.currentWeather
		dayLabel.text = weather.date
	}
}
