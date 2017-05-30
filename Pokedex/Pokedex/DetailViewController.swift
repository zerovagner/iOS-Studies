//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Vagner Oliveira on 5/29/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
	
	var pokemon: Pokemon!

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var bioImage: UIImageView!
	@IBOutlet weak var bioLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var idLabel: UILabel!
	@IBOutlet weak var heightLabel: UILabel!
	@IBOutlet weak var weightLabel: UILabel!
	@IBOutlet weak var attackLabel: UILabel!
	@IBOutlet weak var defenseLabel: UILabel!
	
	
	@IBOutlet weak var nextEvoLabel: UILabel!
	@IBOutlet weak var currentEvoImage: UIImageView!
	@IBOutlet weak var nextEvoImage: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let img = UIImage(named: "\(pokemon.id!)")
		bioImage.image = img
		currentEvoImage.image = img
		
		idLabel.text = "\(pokemon.id!)"
		nameLabel.text = pokemon.name.capitalized
		pokemon.downloadPokemonDetail {
			self.setUpView()
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func setUpView () {
		attackLabel.text = pokemon.attack
		defenseLabel.text = pokemon.defense
		heightLabel.text = pokemon.height
		weightLabel.text = pokemon.weight
		typeLabel.text = pokemon.type
		bioLabel.text = pokemon.description
		
		if pokemon.evolution == nil {
			nextEvoImage.isHidden = true
			nextEvoLabel.text = "\(pokemon.name.capitalized) has no evolutions"
		} else {
			nextEvoImage.isHidden = false
			nextEvoImage.image = UIImage(named: "\(pokemon.evolution.id!)")
			nextEvoLabel.text = "Next evolution: \(pokemon.evolution.name!): lv \(pokemon.evolutionLvl!)"
		}
	}

	@IBAction func backPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}
