//
//  Party.swift
//  PartyRockMansion
//
//  Created by Vagner Oliveira on 5/9/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation

class Party {
	private(set) var imageURL: String
	private(set) var videoURL: String
	private(set) var videoTitle: String
	
	init(imageURL: String, videoURL: String, videoTitle: String) {
		self.imageURL = imageURL
		self.videoURL = videoURL
		self.videoTitle = videoTitle
	}
	
}
