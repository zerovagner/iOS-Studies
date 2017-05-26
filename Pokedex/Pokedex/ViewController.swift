//
//  ViewController.swift
//  Pokedex
//
//  Created by Vagner Oliveira on 5/23/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	var list = [Pokemon]()
	var filteredList = [Pokemon]()
	var musicPlayer: AVAudioPlayer!
	var searchMode = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.dataSource = self
		collectionView.delegate = self
		searchBar.delegate = self
		
		parsePokemonCSV()
		initAudio()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func parsePokemonCSV () {
		let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
		do {
			let csv = try CSV(contentsOfURL: path!)
			let rows = csv.rows
			
			for row in rows {
				list.append(Pokemon(Int(row["id"]!)!,row["identifier"]!))
			}
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	func initAudio() {
		let path = Bundle.main.path(forResource: "music", ofType: "mp3")
		do {
			musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
			musicPlayer.prepareToPlay()
			musicPlayer.numberOfLoops = -1
			musicPlayer.play()
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCollectionViewCell {
			cell.setUpCell(fromPokemon: searchMode ? filteredList[indexPath.row] : list[indexPath.row])
			return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return searchMode ? filteredList.count : list.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 105, height: 105)
	}
	
	@IBAction func musicButtonPressed(_ sender: UIButton) {
		if musicPlayer.isPlaying {
			musicPlayer.pause()
			sender.alpha = 0.2
		} else {
			musicPlayer.play()
			sender.alpha = 1.0
		}
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)
	}
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text == nil || searchBar.text == "" {
			searchMode = false
			view.endEditing(true)
		} else {
			searchMode = true
			filteredList = list.filter({$0.name.range(of: searchText.lowercased()) != nil})
		}
		collectionView.reloadData()
	}
}

