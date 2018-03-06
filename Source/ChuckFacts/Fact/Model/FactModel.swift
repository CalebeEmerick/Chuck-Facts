//
//  FactModel.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

final class FactModel {
	
	let message: String
	let category: String
	let messageFont: UIFont
	let radius: CGFloat
	let categoryBackground: UIColor
	
	init(fact: Fact) {
		message = fact.message
		radius = 2
		
		if let factCategory = fact.category, let category = factCategory.categories.first {
			self.category = category.uppercased()
			categoryBackground = Color(hexString: "#2475b0").color
		}
		else {
			self.category = "N/A"
			categoryBackground = .lightGray
		}
		
		if message.count > 50 {
			messageFont = UIFont.systemFont(ofSize: 14, weight: .semibold)
		}
		else {
			messageFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
		}
	}
}
