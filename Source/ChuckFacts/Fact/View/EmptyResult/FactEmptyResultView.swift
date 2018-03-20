//
//  FactEmptyResultView.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 13/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class FactEmptyResultView: UIView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		accessibilityIdentifier = "FactEmptyResult"
		alpha = 0
	}
	
	func showAnimated() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			UIView.animate(withDuration: 0.25) {
				self.alpha = 1
			}
		}
	}
	
	func setup(for view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		DispatchQueue.main.async {
			view.addSubview(self)
			self.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
				.isActive = true
			self.leadingAnchor.constraint(equalTo: view.leadingAnchor)
				.isActive = true
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
				.isActive = true
			self.heightAnchor.constraint(equalToConstant: self.bounds.height)
				.isActive = true
		}
	}
	
	func removeAnimated(handler: @escaping () -> Void) {
		UIView.animate(withDuration: 0.25, animations: {
			self.alpha = 0
		}) { _ in
			self.removeFromSuperview()
			handler()
		}
	}
}
