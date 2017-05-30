//
//  PokeCollectionViewCell.swift
//  Pokedex
//
//  Created by Vagner Oliveira on 5/25/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var thumbImage: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		layer.cornerRadius = 5.0
	}
	
	func setUpCell(fromPokemon pokemon: Pokemon) {
		nameLabel.text = pokemon.name.capitalized
		thumbImage.image = UIImage(named: "\(pokemon.id!)")
	}
}
