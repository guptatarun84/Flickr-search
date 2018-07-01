//
//  CoreDataManager.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 7/1/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
	static var mainContext: NSManagedObjectContext {
		return persistentContainer.viewContext
	}

	// MARK: - Core data stack
	
	/// Save a given managed object context
	@discardableResult
	static func save(_ context: NSManagedObjectContext) -> Bool {
		do {
			try context.save()
		} catch {
			debugPrint("Failed to save managed object context: \(error.localizedDescription)")
			return false
		}
		return true
	}
	
	static let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "Code_Assignment")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		container.viewContext.automaticallyMergesChangesFromParent = true
		return container
	}()
	
	@discardableResult
	static func saveReport(_ title: String, _ owner: String, _ image: NSData, in context: NSManagedObjectContext) -> PhotoMO? {
		// Create new report item
		if let phone = NSEntityDescription.insertNewObject(forEntityName: PhotoMO.entityName, into: context) as? PhotoMO {
			phone.configure(title, owner, image)
			CoreDataManager.save(context)
			return phone
		} else {
			print("Can`t insert Report Item object to context!")
			return nil
		}
	}
}
