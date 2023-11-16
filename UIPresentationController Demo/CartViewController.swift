//
//  CartViewController.swift
//  UIPresentationController Demo
//

import UIKit

class CartViewController: AppStateViewController, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cart.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		cell.textLabel?.text = cart[indexPath.row]

		return cell
	}
	
	public var cart: [String] {
		get {
			return appState.cart
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction func onBuy(_ sender: Any) {
		appState.cart.removeAll()
		dismiss(animated: true)
	}
}
