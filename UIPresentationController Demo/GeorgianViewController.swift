//
//  GeorgianViewController.swift
//  UIPresentationController Demo
//

import UIKit

class GeorgianViewController: AppStateViewController {
	lazy var slideInTransitionDelegate = SlideInPresentationManager()
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let controller = segue.destination as? CartViewController {
			slideInTransitionDelegate.direction = .right
			controller.transitioningDelegate = slideInTransitionDelegate
			controller.modalPresentationStyle = .custom
		}
	}
}

extension GeorgianViewController : UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		if let cell = cell as? ItalianCollectionViewCell {
			if indexPath.row == 0 {
				cell.button.titleLabel!.text = "Khinkali"
				cell.image.image = UIImage(named: "Khinkali")
			}
			else {
				cell.button.titleLabel!.text = "Ajaruli"
				cell.image.image = UIImage(named: "Ajaruli")
			}
		}
		return cell
	}
}
