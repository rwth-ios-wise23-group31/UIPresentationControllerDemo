//
//  GeorgianViewController.swift
//  UIPresentationController Demo
//

import UIKit

class GeorgianViewController: AppStateViewController {
	lazy var slideInTransitionDelegate = SlideInPresentationManager()
	var detailCell: ItalianCollectionViewCell?
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: sender)
		
		if let controller = segue.destination as? CartViewController {
			slideInTransitionDelegate = SlideInPresentationManager()
			slideInTransitionDelegate.direction = .right
			slideInTransitionDelegate.mainAxisAspectRatio = 2.0/3.0
			controller.transitioningDelegate = slideInTransitionDelegate
			controller.modalPresentationStyle = .custom
		}
		
		if let detailCell = detailCell, let controller = segue.destination as? DetailViewController {
			controller.imageName = detailCell.imageName
			controller.itemName = detailCell.buttonText
			controller.itemDescription = detailCell.itemDescription
			
			slideInTransitionDelegate = SlideInPresentationManager()
			slideInTransitionDelegate.direction = .bottom
			slideInTransitionDelegate.mainAxisAspectRatio = 1.0/3.0
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
				cell.update(withText: "Khinkali", image: "Khinkali", description: "Khinkali are super flavorful, meat-filled dumplings")
			}
			else {
				cell.update(withText: "Ajaruli", image: "Ajaruli", description: "")
			}
			cell.performAction = { cell in
				self.detailCell = cell
				self.performSegue(withIdentifier: "ShowDetail", sender: nil)
			}
		}
		return cell
	}
}
