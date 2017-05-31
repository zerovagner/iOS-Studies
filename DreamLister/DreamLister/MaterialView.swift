//
//  MaterialView.swift
//  DreamLister
//
//  Created by Vagner Oliveira on 5/31/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

private var materialKey = false
extension UIView {
	@IBInspectable var materialDesign: Bool {
		get {
			return materialKey
		}
		set {
			if newValue == true {
				materialKey = true
				self.layer.masksToBounds = false
				self.layer.cornerRadius = 3.0
				self.layer.shadowOpacity = 0.8
				self.layer.shadowRadius = 3.0
				self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
				self.layer.shadowColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1.0).cgColor
			} else {
				materialKey = false
				self.layer.cornerRadius = 0
				self.layer.shadowOpacity = 0
				self.layer.shadowRadius = 0
				self.layer.shadowColor = nil
			}
		}
	}
}
