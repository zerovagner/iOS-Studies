//
//  ItemTableViewCell.swift
//  DreamLister
//
//  Created by Vagner Oliveira on 5/31/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

	@IBOutlet weak var thumbImg: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func configureCell (fromItem item: Item) {
		titleLabel.text = item.title
		priceLabel.text = String(format: "$%.2f", item.price)
		descriptionLabel.text = item.details
		thumbImg.image = item.toImage?.image as? UIImage
	}
}
