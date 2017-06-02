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
		
		attemptFetch()
		if fetchedResultsController.fetchedObjects?.count == 0 {
			generateTestData()
			attemptFetch()
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func segmentChanged(_ sender: UISegmentedControl) {
		attemptFetch()
		tableView.reloadData()
	}
	
	@IBAction func addButtonPressed(_ sender: Any) {
		performSegue(withIdentifier: "detailSegue", sender: nil)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		performSegue(withIdentifier: "detailSegue", sender: fetchedResultsController.object(at: indexPath))
	}
	
	func configureCell(cell: ItemTableViewCell, withIndexPath indexPath: IndexPath) {
		let item = fetchedResultsController.object(at: indexPath)
		cell.configureCell(fromItem: item)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell {
			configureCell(cell: cell, withIndexPath: indexPath)
			return cell
		}
		return UITableViewCell()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections.count
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let sections = fetchedResultsController.sections {
			return sections[section].numberOfObjects
		}
		return 0
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 150
	}
	
	func attemptFetch () {
		let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
		let dateSort = NSSortDescriptor(key: "created", ascending: false)
		let priceSort = NSSortDescriptor(key: "price", ascending: true)
		let titleSort = NSSortDescriptor(key: "title", ascending: true)
		
		switch segment.selectedSegmentIndex {
			case 0:
				fetchRequest.sortDescriptors = [dateSort]
			case 1:
				fetchRequest.sortDescriptors = [priceSort]
			case 2:
				fetchRequest.sortDescriptors = [titleSort]
			default:
				break
		}
		
		fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
		                                            managedObjectContext: context,
		                                            sectionNameKeyPath: nil, cacheName: nil)
		fetchedResultsController.delegate = self
		
		do {
			try fetchedResultsController.performFetch()
		} catch let err as NSError {
			print(err.debugDescription)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "detailSegue" {
			if let detail = segue.destination as? ItemDetailViewController {
				detail.itemToEdit = sender as? Item
			}
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
					let cell = tableView.cellForRow(at: indexPath) as! ItemTableViewCell
					configureCell(cell: cell, withIndexPath: indexPath)
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
	
	func generateTestData() {
		let item = Item(context: context)
		item.title = "MacBook Pro"
		item.price = 1800
		item.details = "I can't wait until the September event, I hope they release new MPBs"
		
		let item2 = Item(context: context)
		item2.title = "Bose Headphones"
		item2.price = 300
		item2.details = "But man, its so nice to be able to blaock out everyone with the noise canceling tech."
		
		let item3 = Item(context: context)
		item3.title = "Tesla Model S"
		item3.price = 110000
		item3.details = "Oh man this is a beautiful car. And one day, I willl own it"
		
		ad.saveContext()
	}

}

