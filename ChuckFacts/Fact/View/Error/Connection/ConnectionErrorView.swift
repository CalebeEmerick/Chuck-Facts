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
	
	private var viewModel: ConnectionErrorViewModel!
	
	var didTapTryAgain: (() -> Void)?
	
	var settingsOpener: SettingsOpenable! {
		didSet {
			viewModel = ConnectionErrorViewModel(settings: settingsOpener)
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		accessibilityIdentifier = "FactConnectionError"
		alpha = 0
		
		makeBorder(for: verifyConnectionButton)
		makeBorder(for: tryAgainButton)
	}
	
	func showAnimated() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
