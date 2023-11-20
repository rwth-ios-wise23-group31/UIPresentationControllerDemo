//
//  ItalianViewController.swift
//  UIPresentationController Demo
//

import UIKit

class ItalianViewController: AppStateViewController {
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
			slideInTransitionDelegate.direction = .left
			slideInTransitionDelegate.mainAxisAspectRatio = 1.0
			slideInTransitionDelegate.crossAxisAspectRatio = 1.0/3.0
			slideInTransitionDelegate.crossAxisAlignment = .middle
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
				cell.update(withText: "Pizza", image: "Pizza", description: "Hawaiian pizza is a pizza originating in Canada, and is traditionally topped with pineapple, tomato sauce, cheese, and either ham or bacon.")
			}
			else {
				cell.update(withText: "Pasta", image: "Pasta", description: "Pasta alla Norma, earlier called \"pasta con le melanzane\"")
			}
			cell.performAction = { cell in
				self.detailCell = cell
				self.performSegue(withIdentifier: "ShowDetail", sender: nil)
			}
		}
		return cell
	}
}
