//
//  SlideInPresentation.swift
//  UIPresentationController Demo
//
//  Inspired by: https://www.kodeco.com/3636807-uipresentationcontroller-tutorial-getting-started?page=3
//

import UIKit

class SlideInPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.3
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let key: UITransitionContextViewControllerKey = operation == .presenting ? .to : .from
		
		guard let controller = transitionContext.viewController(forKey: key) else { return }
			
		if operation == .presenting {
			transitionContext.containerView.addSubview(controller.view)
		}

		let presentedFrame = transitionContext.finalFrame(for: controller)
		var dismissedFrame = presentedFrame
		switch direction {
		case .left:
			dismissedFrame.origin.x = -presentedFrame.width
		case .right:
			dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
		case .top:
			dismissedFrame.origin.y = -presentedFrame.height
		case .bottom:
			dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
		}
		
		let initialFrame = operation == .presenting ? dismissedFrame : presentedFrame
		let finalFrame = operation == .presenting ? presentedFrame : dismissedFrame
		
		// 5
		let animationDuration = transitionDuration(using: transitionContext)
		controller.view.frame = initialFrame
		UIView.animate(
			withDuration: animationDuration,
			animations: {
				controller.view.frame = finalFrame
			}, completion: { finished in
				if self.operation == .dismissing {
					controller.view.removeFromSuperview()
				}
				transitionContext.completeTransition(finished)
			})
	}
	
	let direction: PresentationDirection
	let operation: AnimationOperation
	
	init(direction: PresentationDirection, operation: AnimationOperation) {
		self.direction = direction
		self.operation = operation
		
		super.init()
	}
}

enum AnimationOperation {
	case presenting
	case dismissing
}
