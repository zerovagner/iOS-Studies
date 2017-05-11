//
//  PartyTableViewCell.swift
//  PartyRockMansion
//
//  Created by Vagner Oliveira on 5/9/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {

	@IBOutlet weak var videoPreviewImage: UIImageView!
	@IBOutlet weak var videoTitle: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setUpCell (fromParty party: Party) {
		videoTitle.text = party.videoTitle
		let url = URL(string: party.imageURL)!
		
		DispatchQueue.global().async {
			do {
				let data = try Data(contentsOf: url)
				DispatchQueue.global().sync {
					self.videoPreviewImage.image = UIImage(data: data)
				}
			} catch {
				print("\(error)")
			}
		}
		
	}
}
