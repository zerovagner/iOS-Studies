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

	override func viewDidAppear(_ animated: Bool) {
		let scrollWidth = scrollView.frame.width
		var contentWidth: CGFloat = 0.0
		
		for x in 0..<3 {
			let image = UIImage(named: "icon\(x).png")
			let imageView = UIImageView(image: image)
			images.append(imageView)
			
			let newX = scrollWidth / 2 + scrollWidth * CGFloat(x)
			contentWidth += scrollWidth
			scrollView.addSubview(imageView)
			
			imageView.frame = CGRect(x: newX - 75, y: (view.frame.size.height / 2) - 75, width: 150, height: 150)
		}
		scrollView.contentSize = (CGSize(width: contentWidth, height: view.frame.size.height))
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	@IBAction func swipeLeft(_ sender: UISwipeGestureRecognizer) {
		processSwipe(sender)
	}
	
	@IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
		processSwipe(sender)
	}
	
	func processSwipe(_ sender: UISwipeGestureRecognizer) {
		var newX = CGFloat(0.0)
		if sender.direction == UISwipeGestureRecognizerDirection.left {
			newX = scrollView.contentOffset.x + scrollView.frame.width
			if newX >= scrollView.contentSize.width {
				newX = scrollView.contentSize.width
			}
		}
		if sender.direction == UISwipeGestureRecognizerDirection.right {
			newX = scrollView.contentOffset.x - scrollView.frame.width
			if newX < 0 {
				newX = 0
			}
		}
		scrollView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
	}
}

