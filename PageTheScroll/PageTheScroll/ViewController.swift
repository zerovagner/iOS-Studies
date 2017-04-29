//
//  ViewController.swift
//  PageTheScroll
//
//  Created by Vagner Oliveira on 4/28/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var images = [UIImageView]()
	@IBOutlet weak var scrollView: UIScrollView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		
		let scrollWidth = scrollView.frame.width
		var contentWidth: CGFloat = 0.0
		
		for x in 0..<3 {
			let image = UIImage(named: "icon\(x).png")
			let imageView = UIImageView(image: image)
			images.append(imageView)
			
			let newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
			contentWidth += newX
			scrollView.addSubview(imageView)
			
			imageView.frame = CGRect(x: newX - 75, y: (view.frame.size.height / 2) - 75, width: 150, height: 150)
		}
		scrollView.contentSize = (CGSize(width: contentWidth, height: view.frame.size.height))
	}


}

