//
//  CalculatorButton.swift
//  RetroCalculator
//
//  Created by Vagner Oliveira on 5/8/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import AVFoundation

class CalculatorButton: UIButton {
	
	static let soundPath = Bundle.main.path(forResource: "btn", ofType: "wav")
	static let soundUrl = URL(fileURLWithPath: soundPath!)
	static var btnSound: AVAudioPlayer!

	static func setup() {
		do {
			try btnSound = AVAudioPlayer(contentsOf: soundUrl)
			btnSound.prepareToPlay()
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		if CalculatorButton.btnSound.isPlaying {
			CalculatorButton.btnSound.stop()
		}
		CalculatorButton.btnSound.play()
	}
}
