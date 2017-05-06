//
//  MusicListViewController.swift
//  SwappingScreens
//
//  Created by Vagner Oliveira on 5/5/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class MusicListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.blue

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func backButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	@IBAction func load3rdScreenButtonPressed(_ sender: Any) {
		let songTitle = "Smells Like Teen Spirit"
		performSegue(withIdentifier: "musicListPlaySongSegue", sender: songTitle)
	}
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? PlaySongViewController {
			if let song = sender as? String {
				destination.selectedSong = song
			}
		}
	}
}
