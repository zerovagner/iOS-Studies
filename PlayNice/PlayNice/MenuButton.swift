//
//  MenuButton.swift
//  PlayNice
//
//  Created by Vagner Oliveira on 6/3/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

@IBDesignable
class MenuButton: UIButton {
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		self.titleLabel?.layer.borderColor = UIColor.red.cgColor
		self.titleLabel?.layer.borderWidth = 1.0
		self.titleLabel?.textColor = UIColor.blue
		self.titleLabel?.layer.backgroundColor = UIColor.red.cgColor
		self.titleLabel?.layer.cornerRadius = 7.0
		self.titleLabel?.isHighlighted = true
	}
}
