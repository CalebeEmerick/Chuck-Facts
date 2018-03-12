//
//  InternalErrorView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 12/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class InternalErrorView: UIView {
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		alpha = 0
	}
	
	func showAnimated() {
		UIView.animate(withDuration: 0.25) {
			self.alpha = 1
		}
	}
	
	func setup(for view: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		DispatchQueue.main.async {
			view.addSubview(self)
			view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
			view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
			view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
			view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		}
	}
	
	func remove(from superview: UIView) {
		removeFromSuperview()
	}
}
