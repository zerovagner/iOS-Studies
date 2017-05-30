//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vagner Oliveira on 5/23/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import Foundation
import Alamofire

let BASE_URL = "http://pokeapi.co"
let POKEMON = "/api/v1/pokemon/"

class Pokemon {
	private(set) var name: String!
	private(set) var id: Int!
	private(set) var description :String!
	private(set) var type :String!
	private(set) var attack :String!
	private(set) var defense :String!
	private(set) var height :String!
	private(set) var weight :String!
	private(set) var evolutionLvl :String!
	private(set) var evolution: Pokemon!
	
	init(_ id: Int, _ name: String) {
		self.name = name
		self.id = id
	}
	
	func downloadPokemonDetail (completed: @escaping () -> ()) {
		Alamofire.request("\(BASE_URL)\(POKEMON)\(id!)").responseJSON { (response) in
			if let dict = response.result.value as? [String:Any] {
				if let height = dict["height"] as? String {
					self.height = height
				}
				if let weight = dict["weight"] as? String {
					self.weight = weight
				}
				if let attack = dict["attack"] as? Int {
					self.attack = "\(attack)"
				}
				if let defense = dict["defense"] as? Int {
					self.defense = "\(defense)"
				}
				if let types = dict["types"] as? [[String:String]] {
					self.type = ""
					for type in types {
						if self.type != "" {
							self.type = self.type + "/"
						}
						self.type = self.type + type["name"]!.capitalized
					}
				}
				
				if let descArray = dict["descriptions"] as? [[String:String]] {
					self.description = ""
					if let url = descArray[0]["resource_uri"] {
						print("\(BASE_URL)\(url)")
						Alamofire.request("\(BASE_URL)\(url)").responseJSON { (response) in
							if let res = response.result.value as? [String:Any] {
								if let description = res["description"] as? String {
									self.description = description
								}
							}
							completed()
						}
					}
				}
				
				if let evolutions = dict["evolutions"] as? [[String:Any]] {
					if let nextEvo = evolutions[0]["to"] as? String {
						if nextEvo.range(of: "mega") == nil {
							let nextEvoName = nextEvo
							let uri = evolutions[0]["resource_uri"] as! String
							let nextEvoId = Int(uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "").replacingOccurrences(of: "/", with: ""))
							self.evolution = Pokemon(nextEvoId!,nextEvoName)
							if let lvlExist = evolutions[0]["level"] as? Int {
								self.evolutionLvl = "\(lvlExist)"
							}
							print(self.evolutionLvl)
							print(self.evolution.id)
							print(self.evolution.name)
						}
					}
				}
			}
			completed()
		}
	}
}
