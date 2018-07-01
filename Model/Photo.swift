//
//  Photo.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 7/1/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import SwiftyJSON

class Photo: NSObject {
	var farm: Int?
	var height_s : String?
	var id: String?
	var isfamily: Int?
	var isfriend: Int?
	var ispublic : Int?
	var owner: String?
	var secret: String?
	var server: String?
	var title: String?
	var url_s: String?
	var width_s: String?

	init(dict: JSON){
		self.farm = dict["farm"].int
		self.height_s = dict["height_s"].string
		self.id = dict["id"].string
		self.isfamily = dict["isfamily"].int
		self.isfriend = dict["isfriend"].int
		self.ispublic = dict["ispublic"].int
		self.owner = dict["owner"].string
		self.secret = dict["secret"].string
		self.server = dict["server"].string
		self.title = dict["title"].string
		self.url_s = dict["url_s"].string
		self.width_s = dict["width_s"].string
	}
}
