//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vagner Oliveira on 5/23/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation

class Pokemon {
	private(set) var name: String!
	private(set) var id: Int!
	
	init(_ id: Int, _ name: String) {
		self.name = name
		self.id = id
	}
}
