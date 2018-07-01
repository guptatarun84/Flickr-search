//
//  PhotoMO.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 7/1/18.
//	Copyright © 2018 Tarun Gupta. All rights reserved.
//

import Foundation
import CoreData

@objc(PhotoMO)
public class PhotoMO: NSManagedObject {
	static let entityName = "PhotoMO"

	@nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoMO> {
		return NSFetchRequest<PhotoMO>(entityName: "PhotoMO")
	}
	
	@NSManaged public var title: String?
	@NSManaged public var owner: String?
	@NSManaged public var image: NSData?
	
	/// Cofigure PhotoMO class
	///
	func configure(_ title: String, _ owner: String, _ image: NSData?) {
		self.title = title
		self.owner = owner
		self.image = image
	}
}
