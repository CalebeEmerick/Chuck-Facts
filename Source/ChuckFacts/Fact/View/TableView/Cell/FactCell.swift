//
//  FactCell.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class FactCell: UITableViewCell {
	
	@IBOutlet private var messageLabel: UILabel!
	@IBOutlet private var categoryLabel: UILabel!
	@IBOutlet private var categoryContainer: UIView!
	
	var fact: FactModel? {
		didSet {
			updateUI()
		}
	}
	
	private func updateUI() {
		guard let fact = fact else { return }
		fillOutlets(for: fact)
	}
	
	private func fillOutlets(for model: FactModel) {
		DispatchQueue.main.async {
			self.messageLabel.text = model.message
			self.categoryLabel.text = model.category
			self.categoryContainer.layer.cornerRadius = model.radius
			self.categoryContainer.backgroundColor = model.categoryBackground
			self.messageLabel.font = model.messageFont
		}
	}
}
