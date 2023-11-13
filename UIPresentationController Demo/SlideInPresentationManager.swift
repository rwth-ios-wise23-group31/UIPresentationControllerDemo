//
//  SlideInPresentationManager.swift
//  UIPresentationController Demo
//
//  Created by Kenneth Bruen on 13.11.2023.
//

import UIKit

class SlideInPresentationManager: NSObject {
	var direction: PresentationDirection = .left
}

extension SlideInPresentationManager : UIViewControllerTransitioningDelegate {
	func presentationController(
		forPresented presented: UIViewController,
		presenting: UIViewController?,
		source: UIViewController
	) -> UIPresentationController? {
		let presentationController = SlideInPresentationController(
			presentedViewController: presented,
			presenting: presenting,
			direction: direction
		)
		return presentationController
	}
}

enum PresentationDirection {
	case top
	case bottom
	case left
	case right
}
