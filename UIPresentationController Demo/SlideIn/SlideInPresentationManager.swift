//
//  SlideInPresentationManager.swift
//  UIPresentationController Demo
//

import UIKit

class SlideInPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
	var direction: PresentationDirection = .left
	
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
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SlideInPresentationAnimator(direction: direction, operation: .presenting)
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return SlideInPresentationAnimator(direction: direction, operation: .dismissing)
	}
}

enum PresentationDirection {
	case top
	case bottom
	case left
	case right
}
