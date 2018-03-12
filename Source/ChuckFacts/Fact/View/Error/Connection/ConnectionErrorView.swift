//
//  ConnectionErrorView.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 12/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class ConnectionErrorView: UIView {
	
	@IBOutlet private var verifyConnectionButton: UIButton!
	@IBOutlet private var tryAgainButton: UIButton!
	
	@IBAction private func verifyConnectionAction() {
		viewModel.openSettings()
	}
	
	@IBAction private func tryAgainAction() {
		didTapTryAgain?()
	}
	
	private let viewModel: ConnectionErrorViewModel
	
	var didTapTryAgain: (() -> Void)?
	
	required init?(coder aDecoder: NSCoder) {
		viewModel = ConnectionErrorViewModel()
		
		super.init(coder: aDecoder)
		
		alpha = 0
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		makeBorder(for: verifyConnectionButton)
		makeBorder(for: tryAgainButton)
	}
	
	func showAnimated() {
		DispatchQueue.main.async {
			UIView.animate(withDuration: 0.25) {
				self.alpha = 1
			}
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
	
	func removeAnimated(handler: @escaping () -> Void) {
		UIView.animate(withDuration: 0.3, animations: {
			self.alpha = 0
		}) { _ in
			self.removeFromSuperview()
			handler()
		}
	}
	
	private func makeBorder(for button: UIButton) {
		button.layer.borderWidth = 1
		button.layer.borderColor = Color(hexString: "#007AFF").cgColor
		button.layer.cornerRadius = 4
		button.clipsToBounds = true
	}
}
