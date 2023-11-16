//
//  AppStateViewController.swift
//  UIPresentationController Demo
//

import UIKit

class AppStateViewController: UIViewController {
	var appState: AppState!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let destination = segue.destination as? AppStateViewController {
			destination.appState = appState
		}
    }

}
