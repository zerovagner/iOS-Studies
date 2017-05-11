//
//  VideoViewController.swift
//  PartyRockMansion
//
//  Created by Vagner Oliveira on 5/9/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

	@IBOutlet weak var webView: UIWebView!
	@IBOutlet weak var titleLabel: UILabel!
	
	private var party: Party!
	
	func setParty (_ newParty: Party) {
		party = newParty
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = party.videoTitle
		webView.loadHTMLString(party.videoURL, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
