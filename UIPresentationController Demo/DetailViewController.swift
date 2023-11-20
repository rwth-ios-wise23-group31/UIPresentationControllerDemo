//
//  DetailViewController.swift
//  UIPresentationController Demo
//
//  Created by Kenneth Bruen on 20.11.2023.
//

import UIKit

class DetailViewController: CartViewController {
	var itemName: String = ""
	var imageName: String = ""
	var itemDescription: String = ""

    override func viewDidLoad() {
		label.text = itemDescription
		imageView.image = UIImage(named: imageName)
		
		super.viewDidLoad()
    }

	@IBAction func onAddToCart(_ sender: Any) {
		appState.cart.append(itemName)
		dismiss(animated: true)
	}
	@IBOutlet weak var label: UILabel!
	@IBOutlet weak var imageView: UIImageView!
}
