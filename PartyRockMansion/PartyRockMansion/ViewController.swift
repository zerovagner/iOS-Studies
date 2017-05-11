//
//  ViewController.swift
//  PartyRockMansion
//
//  Created by Vagner Oliveira on 5/9/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var partyTableView: UITableView!
	var parties = [Party]()

	override func viewDidLoad() {
		super.viewDidLoad()
		partyTableView.delegate = self
		partyTableView.dataSource = self
		
		createDummyData()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if let cell = partyTableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyTableViewCell {
			cell.setUpCell(fromParty: parties[indexPath.row])
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return parties.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let party = parties[indexPath.row]
		performSegue(withIdentifier: "mainVideoSegue", sender: party)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? VideoViewController {
			if let party = sender as? Party {
				vc.setParty(party)
			}
		}
	}
	
	func createDummyData() {
		let images = [
			"https://i.ytimg.com/vi/CvpV4kDQeKU/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=W4Do7QecU9tbJXX13qX370Va9cs",
			"https://i.ytimg.com/vi/5_VKCpmJ7b8/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=NK60U1nw0ONdv6wusyT0gvpRbZM",
			"https://i.ytimg.com/vi/q9BBP7tkyms/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=ds-o2lk-yd07YgAj4z6abU39hV8",
			"https://i.ytimg.com/vi/cXvT-2DOrjo/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=_5PCLmAnilEnxGTxHvY0na3hhfs"
		]
		
		let iframes = [
			"<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/CvpV4kDQeKU\" frameborder=\"0\" allowfullscreen></iframe>",
			"<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/5_VKCpmJ7b8\" frameborder=\"0\" allowfullscreen></iframe>",
			"<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/q9BBP7tkyms\" frameborder=\"0\" allowfullscreen></iframe>",
			"<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/cXvT-2DOrjo\" frameborder=\"0\" allowfullscreen></iframe>"
		]
		
		let titles = [
			"LAUGHING",
			"KNOW 70s MUSIC",
			"DOG FOOD VS REAL FOOD",
			"OREO CHALLENGE"
		]
		
		for i in 0..<images.count {
			let p = Party(imageURL: images[i], videoURL: iframes[i], videoTitle: titles[i])
			parties.append(p)
		}
	}
	
}

