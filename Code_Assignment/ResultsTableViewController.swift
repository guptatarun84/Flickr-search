//
//  ResultsTableViewController.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 6/30/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
	let searchController = UISearchController(searchResultsController: nil)
	var arrResponse: [Photo] = []
	var fullViewImage: UIImage?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchBar()
		
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		self.definesPresentationContext = true
		// Uncomment the following line to preserve selection between presentations
		// self.clearsSelectionOnViewWillAppear = false
		
		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// self.navigationItem.rightBarButtonItem = self.editButtonItem
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	fileprivate func setupSearchBar() {
		searchController.searchResultsUpdater = self
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.delegate = self
		searchController.delegate = self
		tableView.tableHeaderView = searchController.searchBar
	}
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrResponse.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
		let dict = arrResponse[indexPath.row]
		cell.textLabel?.text = dict.title
		cell.detailTextLabel?.text = dict.owner
		
		getPhoto(url: dict.url_s!, completionHandler: { image in
			cell.imageView?.image = image
//			cell.imageView?.image = self.imageWithImage(image: image!,
//														scaledToSize: CGSize(width: 40, height: 40))
		})

		cell.accessoryType = .disclosureIndicator
		cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		return cell
	}
	
	// MARK: - Table view delegate
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 60
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let dict = arrResponse[indexPath.row]
		getPhoto(url: dict.url_s!, completionHandler: { image in
			self.fullViewImage = image
			self.performSegue(withIdentifier: "showImage", sender: self)
		})
	}

	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
		if segue.identifier == "showImage" {
			if let imageViewController = segue.destination as? ImageViewController {
				imageViewController.image = self.fullViewImage
			}
		}
		
	}

	
	func imageWithImage(image:UIImage,scaledToSize newSize:CGSize)->UIImage{
		UIGraphicsBeginImageContext( newSize )
		image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!.withRenderingMode(.alwaysTemplate)
	}
}

extension ResultsTableViewController : UISearchControllerDelegate, UISearchBarDelegate {
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.arrResponse.removeAll()
		self.tableView.reloadData()
	}
}

extension ResultsTableViewController : UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		if !searchController.isActive {
			print("Cancelled")
		}
		if let searchText = searchController.searchBar.text, searchText.count > 0 {
			getSearchResults(searchText: searchText,
							 completionHandler: { response, error in
								self.arrResponse = (response?.photos)!
								if self.arrResponse.count > 0 {
									self.tableView.reloadData()
									print(self.arrResponse.count)
								}
			})
		}
		else {
			//
			self.arrResponse.removeAll()
			self.tableView.reloadData()
		}
	}
}
