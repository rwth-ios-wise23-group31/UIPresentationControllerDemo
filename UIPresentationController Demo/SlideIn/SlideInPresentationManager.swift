//
//  SlideInPresentationManager.swift
//  UIPresentationController Demo
//
//  Inspired by: https://www.kodeco.com/3636807-uipresentationcontroller-tutorial-getting-started?page=3
//

import UIKit

class SlideInPresentationManager: NSObject, UIViewControllerTransitioningDelegate {
	var direction: PresentationDirection = .left
	var mainAxisAspectRatio = 2.0/3.0
	var crossAxisAspectRatio = 1.0
	var crossAxisAlignment: Alignment = .stretch
	
	func presentationController(
		forPresented presented: UIViewController,
		presenting: UIViewController?,
		source: UIViewController
	) -> UIPresentationController? {
		let presentationController = SlideInPresentationController(
			presentedViewController: presented,
			presenting: presenting,
			direction: direction,
			mainAxisAspectRatio: mainAxisAspectRatio,
			crossAxisAspectRatio: crossAxisAspectRatio,
			crossAxisAlignment: crossAxisAlignment
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

enum Alignment {
	case start
	case middle
	case end
	case stretch
}
