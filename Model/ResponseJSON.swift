//
//  ResponseJSON.swift
//  iOS Code
//
//  Created by Tarun Gupta on 4/20/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

class ResponseJSON {
	var page: Int?
	var pages: Int?
	var perpage: Int?
	var total: String?
	var stat: String?
	var photos = [Photo]()

	init(json: JSON?) {
		if let resData = json!["photos"].dictionary {
			page = resData["page"]?.int
			pages = resData["pages"]?.int
			perpage = resData["perpage"]?.int
			total = resData["total"]?.string
			stat = resData["stat"]?.string
			for photo in (resData["photo"]?.array)! {
				photos.append(Photo(dict: photo))
			}
		}
	}
}
