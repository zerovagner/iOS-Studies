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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func backPressed(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}
