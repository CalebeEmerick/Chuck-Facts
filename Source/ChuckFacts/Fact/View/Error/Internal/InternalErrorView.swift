//
//  InternalErrorView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 12/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class InternalErrorView: UIView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		accessibilityIdentifier = "FactInternalError"
		alpha = 0
	}
	
	func showAnimated() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
			UIView.animate(withDuration: 0.25) {
				self.alpha = 1
			}
		}
	}
	
	func setup(for view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		DispatchQueue.main.async {
			view.addSubview(self)
			self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
			self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
			self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		}
	}
}
