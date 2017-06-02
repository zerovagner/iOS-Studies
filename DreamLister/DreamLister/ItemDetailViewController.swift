//
//  ItemDetailViewController.swift
//  DreamLister
//
//  Created by Vagner Oliveira on 5/31/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var itemTypePicker: UIPickerView!
	@IBOutlet weak var storePicker: UIPickerView!
	@IBOutlet weak var titleTextField: CustomTextField!
	@IBOutlet weak var priceTextField: CustomTextField!
	@IBOutlet weak var descriptionTextField: CustomTextField!
	@IBOutlet weak var thumbImage: UIImageView!
	
	var stores = [Store]()
	var itemTypes = [ItemType]()
	var itemToEdit: Item?
	var imagePicker: UIImagePickerController!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		if let topItem = navigationController?.navigationBar.topItem {
			topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
		}
		storePicker.dataSource = self
		storePicker.delegate = self
		itemTypePicker.dataSource = self
		itemTypePicker.delegate = self
		getStores()
		if stores.count == 0 {
			generateTestData()
			getStores()
		}
		getItemTypes()
		if itemTypes.count == 0 {
			generateItemTypeTestData()
			getItemTypes()
		}
		
		if itemToEdit != nil {
			loadItemData()
		}
		
		imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return pickerView == storePicker ? stores[row].name : itemTypes[row].type
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return pickerView == storePicker ? stores.count : itemTypes.count
	}
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		
	}
	
	func getStores() {
		let fr: NSFetchRequest<Store> = Store.fetchRequest()
		do {
			stores = try context.fetch(fr)
			storePicker.reloadAllComponents()
		} catch let err as NSError {
			print(err.description)
		}
	}
	
	func getItemTypes() {
		let fr: NSFetchRequest<ItemType> = ItemType.fetchRequest()
		do {
			itemTypes = try context.fetch(fr)
			
		} catch let err as NSError {
			print(err.description)
		}
	}
	
	@IBAction func savePressed(_ sender: UIButton) {
		let item = (itemToEdit != nil) ? itemToEdit! : Item(context: context)
		let picture = Image(context: context)
		
		if let title = titleTextField.text {
			item.title = title
		}
		
		if let price = priceTextField.text, let dPrice = Double(price) {
			item.price = dPrice
		}
		
		if let details = descriptionTextField.text {
			item.details = details
		}
		
		picture.image = thumbImage.image
		item.toImage = picture
		
		item.toItemType = itemTypes[itemTypePicker.selectedRow(inComponent: 0)]
		item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
		ad.saveContext()
		
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func deletePressed(_ sender: UIBarButtonItem) {
		if itemToEdit != nil {
			context.delete(itemToEdit!)
			ad.saveContext()
		}
		navigationController?.popViewController(animated: true)
	}
	
	@IBAction func addImage(_ sender: UIButton) {
		present(imagePicker, animated: true)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
			thumbImage.image = img
		}
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	func loadItemData() {
		titleTextField.text = itemToEdit?.title
		priceTextField.text = String(format: "%.2f",(itemToEdit?.price)!)
		descriptionTextField.text = itemToEdit?.details
		thumbImage.image = itemToEdit?.toImage?.image as? UIImage
		
		if let store = itemToEdit?.toStore {
			var index = 0
			repeat {
				if stores[index].name == store.name {
					storePicker.selectRow(index, inComponent: 0, animated: false)
					break
				}
				index += 1
			} while index < stores.count
		}
		if let itemType = itemToEdit?.toItemType {
			var index = 0
			repeat {
				if itemTypes[index].type == itemType.type {
					itemTypePicker.selectRow(index, inComponent: 0, animated: false)
					break
				}
				index += 1
			} while index < itemTypes.count
		}
	}
	
	func generateTestData () {
		let store = Store(context: context)
		store.name = "Best Buy"
		let store2 = Store(context: context)
		store2.name = "Tesla Dealership"
		let store3 = Store(context: context)
		store3.name = "Frys Electronics"
		let store4 = Store(context: context)
		store4.name = "Target"
		let store5 = Store(context: context)
		store5.name = "Amazon"
		let store6 = Store(context: context)
		store6.name = "K Mart"
		ad.saveContext()
	}
	
	func generateItemTypeTestData () {
		let itemType = ItemType(context: context)
		itemType.type = "Computer"
		let itemType2 = ItemType(context: context)
		itemType2.type = "Automobile"
		let itemType3 = ItemType(context: context)
		itemType3.type = "TV"
		let itemType4 = ItemType(context: context)
		itemType4.type = "Music"
	}
}
