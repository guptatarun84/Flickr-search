//
//  AlamoFireWrapper.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 6/30/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AlamoFireWrapper: NSObject {
	class func requestGETURL(_ strURL: String,
							 success:@escaping (JSON) -> Void,
							 failure:@escaping (Error) -> Void) {
		Alamofire.request(strURL,
						  method: .get,
						  parameters: [:],
						  encoding: URLEncoding.default,
						  headers: nil).responseJSON { (responseObject) -> Void in
							if responseObject.result.isSuccess {
								let resJson = JSON(responseObject.result.value!)
								success(resJson)
							}
							if responseObject.result.isFailure {
								let error : Error = responseObject.result.error!
								failure(error)
							}
		}
	}
	
	class func requestPOSTURL(_ strURL : String,
							  params : [String : AnyObject]?,
							  headers : [String : String]?,
							  success:@escaping (JSON) -> Void,
							  failure:@escaping (Error) -> Void) {
		Alamofire.request(strURL,
						  method: .post,
						  parameters: params,
						  encoding: JSONEncoding.default,
						  headers: headers).responseString { (responseObject) -> Void in
							if responseObject.result.isSuccess {
								let resJson = JSON(responseObject.result.value!)
								success(resJson)
							}
							if responseObject.result.isFailure {
								let error : Error = responseObject.result.error!
								failure(error)
							}
		}
	}

	// Mark: - AlamofireImage- requestImage
	class func requestImage(path: String,
							completionHandler: @escaping (Image) -> Void) {
		Alamofire.request("\(path)").responseImage(imageScale: 1.5,
												   inflateResponseImage: false,
												   completionHandler: { response in
			guard let image = response.result.value else{
				print(response.result)
				return
			}
			DispatchQueue.main.async {
				completionHandler(image)
			}
		})
	}
}
