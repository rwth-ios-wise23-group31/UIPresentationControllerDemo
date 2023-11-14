//
//  ViewController.swift
//  UIPresentationController Demo
//
//  Created by Kenneth Bruen on 13.11.2023.
//

import UIKit

class HomePageViewController: UIViewController {
	
	lazy var slideInTransitionDelegate = SlideInPresentationManager()
	var cart: [String] = []
	
	@IBOutlet weak var italianImage: UIImageView!
	@IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		italianImage.addGestureRecognizer(tapGestureRecognizer)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let controller = segue.destination as? Page2ViewController {
			controller.cart = cart
			slideInTransitionDelegate.direction = .right
			controller.transitioningDelegate = slideInTransitionDelegate
			controller.modalPresentationStyle = .custom
		}
		
		if segue.identifier == "Page3" {
			let controller = segue.destination
			slideInTransitionDelegate.direction = .left
			controller.transitioningDelegate = slideInTransitionDelegate
			controller.modalPresentationStyle = .custom
		}
	}
	
	
	@IBAction func addItem(_ sender: UIButton) {
		if var product = sender.titleLabel?.text {
			if product.starts(with: "Add ") {
				product = String(product.suffix(from: product.index(product.startIndex, offsetBy: 4)))
			}
			cart.append(product)
		}
	}
	
}

