//
//  ImageViewController.swift
//  Code_Assignment
//
//  Created by Tarun Gupta on 7/1/18.
//  Copyright © 2018 Tarun Gupta. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView?
	var image: UIImage?

	override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		imageView?.image = image ?? UIImage(named: "1402222804868")
		// Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
