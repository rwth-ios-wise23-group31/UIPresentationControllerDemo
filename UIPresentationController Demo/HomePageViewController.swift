//
//  HomePageViewController.swift
//  UIPresentationController Demo
//

import UIKit

class HomePageViewController: AppStateViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Initialize the global app state
		appState = AppState()
	}
	
	
	@IBAction func addItem(_ sender: UIButton) {
		if var product = sender.titleLabel?.text {
			if product.starts(with: "Add ") {
				product = String(product.suffix(from: product.index(product.startIndex, offsetBy: 4)))
			}
			appState.cart.append(product)
		}
	}
	
}

