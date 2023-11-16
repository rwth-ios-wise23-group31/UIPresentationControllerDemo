//
//  ItalianViewController.swift
//  UIPresentationController Demo
//

import UIKit

class ItalianViewController: AppStateViewController {
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

extension ItalianViewController : UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
		if let cell = cell as? ItalianCollectionViewCell {
			if indexPath.row == 0 {
				cell.button.titleLabel!.text = "Pizza"
				cell.image.image = UIImage(named: "Pizza")
			}
			else {
				cell.button.titleLabel!.text = "Pasta"
				cell.image.image = UIImage(named: "Pasta")
			}
		}
		return cell
	}
}
