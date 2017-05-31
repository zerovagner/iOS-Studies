//
//  ViewController.swift
//  DreamLister
//
//  Created by Vagner Oliveira on 5/31/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

	@IBOutlet weak var segment: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView!
	
	var fetchedResultsController: NSFetchedResultsController<Item>!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 0
	}
	
	func attemptFetch () {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
		let dateSort = NSSortDescriptor(key: "created", ascending: false)
		let appDelegate = UIApplication.shared.delegate as? AppDelegate
		let managedObjectContext = appDelegate?.persistentContainer.viewContext
		fetchRequest.sortDescriptors = [dateSort]
		
		let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
		                                            managedObjectContext: managedObjectContext!,
		                                            sectionNameKeyPath: nil, cacheName: nil)
		
		do {
			try controller.performFetch()
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.beginUpdates()
	}
	
	func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		tableView.endUpdates()
	}
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
		switch type {
			case .insert:
				if let indexPath = newIndexPath {
					tableView.insertRows(at: [indexPath], with: .fade)
				}
			case .delete:
				if let indexPath = indexPath {
					tableView.deleteRows(at: [indexPath], with: .fade)
				}
			case .update:
				if let indexPath = indexPath {
					let cell = tableView.cellForRow(at: indexPath)
					//update cell
				}
			case .move:
				if let indexPath = indexPath {
					tableView.deleteRows(at: [indexPath], with: .fade)
				}
				if let newIndexPath = newIndexPath {
					tableView.insertRows(at: [newIndexPath], with: .fade)
				}
		}
	}
}

