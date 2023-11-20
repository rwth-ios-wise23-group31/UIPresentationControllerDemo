//
//  SlideInPresentationController.swift
//  UIPresentationController Demo
//
//  Inspired by: https://www.kodeco.com/3636807-uipresentationcontroller-tutorial-getting-started?page=3
//

import UIKit

class SlideInPresentationController: UIPresentationController {
	private var direction: PresentationDirection = .left
	private var mainAxisAspectRatio: Double
	private var crossAxisAspectRatio = 1.0
	private var crossAxisAlignment: Alignment = .stretch
	private var dimmingView: UIView!

	init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection, mainAxisAspectRatio: Double, crossAxisAspectRatio: Double = 1.0, crossAxisAlignment: Alignment = .stretch) {
		self.mainAxisAspectRatio = mainAxisAspectRatio
		self.direction = direction
		self.crossAxisAlignment = crossAxisAlignment
		self.crossAxisAspectRatio = crossAxisAspectRatio
		
		super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
		
		setupDimmingView()
	}

	private func setupDimmingView() {
		dimmingView = UIView()
		dimmingView.translatesAutoresizingMaskIntoConstraints = false
		dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
		dimmingView.alpha = 0.0
		
		let recognizer = UITapGestureRecognizer(
		  target: self,
		  action: #selector(handleTap(recognizer:)))
		dimmingView.addGestureRecognizer(recognizer)
	}
	
	@objc func handleTap(recognizer: UITapGestureRecognizer) {
	  presentingViewController.dismiss(animated: true)
	}
	
	override func presentationTransitionWillBegin() {
		guard let dimmingView = dimmingView else {
			return
		}
		
		containerView?.insertSubview(dimmingView, at: 0)
		
		NSLayoutConstraint.activate(
			NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
										   options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		NSLayoutConstraint.activate(
			NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
										   options: [], metrics: nil, views: ["dimmingView": dimmingView]))
		
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 1.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 1.0
		})
	}
	
	override func dismissalTransitionWillBegin() {
		guard let coordinator = presentedViewController.transitionCoordinator else {
			dimmingView.alpha = 0.0
			return
		}
		
		coordinator.animate(alongsideTransition: { _ in
			self.dimmingView.alpha = 0.0
		})
	}
	
	override func containerViewWillLayoutSubviews() {
		presentedView?.frame = frameOfPresentedViewInContainerView
	}
	
	override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
		switch direction {
		case .left, .right:
			return CGSize(width: parentSize.width * mainAxisAspectRatio, height: parentSize.height * crossAxisAspectRatio)
		case .bottom, .top:
			return CGSize(width: parentSize.width * crossAxisAspectRatio, height: parentSize.height * mainAxisAspectRatio)
		}
	}
	
	override var frameOfPresentedViewInContainerView: CGRect {
		var frame: CGRect = .zero
		frame.size = size(forChildContentContainer: presentedViewController,
						  withParentContainerSize: containerView!.bounds.size)
		
		let cvFrame = containerView!.frame
		
		switch direction {
		case .right:
			frame.origin.x = cvFrame.width * (1.0 - mainAxisAspectRatio)
		case .bottom:
			frame.origin.y = cvFrame.height * (1.0 - mainAxisAspectRatio)
		default:
			frame.origin = .zero
		}
		
		switch crossAxisAlignment {
		case .start, .stretch:
			// Keep the same
			break
		case .middle:
			switch direction {
			case .left, .right:
				frame.origin.y = (cvFrame.height / 2.0) - (frame.height / 2.0)
			case .top, .bottom:
				frame.origin.x = (cvFrame.width / 2.0) - (frame.width / 2.0)
			}
		case .end:
			switch direction {
			case .left, .right:
				frame.origin.y = (cvFrame.height) - (frame.height)
			case .top, .bottom:
				frame.origin.x = (cvFrame.width) - (frame.width)
			}

		}
		return frame
	}
}
