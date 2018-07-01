
//  ServiceHandler.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 6/30/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import Foundation
import SwiftyJSON
import AlamofireImage
import CoreLocation

let PHOTO_URL_SEARCH = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=675894853ae8ec6c242fa4c077bcf4a0&extras=url_s&format=json&nojsoncallback=1"
let KEY : String = "675894853ae8ec6c242fa4c077bcf4a0"

/*!
* discussion This method is a request to fetch the results based on search string.
* @param searchText- Search String
* @returns completionHandler - success
* @exception completionHandler - error
*/
func getSearchResults(searchText: String, completionHandler: @escaping (ResponseJSON?, Error?) -> ()) {
	let url = "\(PHOTO_URL_SEARCH)&\("text=")\(searchText)"
	AlamoFireWrapper.requestGETURL(url, success: {
		(jsonResponse) -> Void in
		completionHandler(ResponseJSON(json: jsonResponse), nil) // Some error- Will fix later
	}) {
		(error) -> Void in
		completionHandler(nil, error)
	}
}

/*!
* discussion This method is a request to fetch images for display.
* @param url- ImageURL String
* @returns completionHandler - success
* @exception completionHandler - error
*/
func getPhoto(url: String, completionHandler: @escaping (Image?) -> Void) {
	let url = url
	AlamoFireWrapper.requestImage(path: url, completionHandler: { image in
		completionHandler(image)
	})
}
