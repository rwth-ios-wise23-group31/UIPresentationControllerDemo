//
//  ItalianCollectionViewCell.swift
//  UIPresentationController Demo
//
//  Created by Kenneth Bruen on 16.11.2023.
//

import UIKit

class ItalianCollectionViewCell: UICollectionViewCell {
	var buttonText: String = "" {
		didSet {
			button.setTitle(self.buttonText, for: .normal)
		}
	}
	var imageName: String = "" {
		didSet {
			image.image = UIImage(named: self.imageName)
		}
	}
	var itemDescription: String = ""
	var performAction: ((_: ItalianCollectionViewCell) -> ())?
	
	override func awakeFromNib() {
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
		
		super.awakeFromNib()
		
		self.image.isUserInteractionEnabled = true
		self.image.addGestureRecognizer(tapGesture)
		self.button.addTarget(self, action: #selector(handleTap), for: .primaryActionTriggered)
	}
	
	func update(withText buttonText: String, image imageName: String, description itemDescription: String) {
		self.buttonText = buttonText
		self.imageName = imageName
		self.itemDescription = itemDescription
	}
	
	@objc func handleTap() {
		if let performAction = performAction {
			performAction(self)
		}
	}
    
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var image: ScaledHeightImageView!
}
