//
//  PlaySongViewController.swift
//  SwappingScreens
//
//  Created by Vagner Oliveira on 5/5/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class PlaySongViewController: UIViewController {

	@IBOutlet weak var songTitleLabel: UILabel!
	
	private var _selectedSong: String!
	
	var selectedSong: String {
		get {
			return _selectedSong
		}
		set {
			_selectedSong = newValue
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		songTitleLabel.text = _selectedSong
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
