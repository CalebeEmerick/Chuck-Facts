//
//  FactCategory.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 02/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct FactCategory {
	
	let categories: [String]
}

extension FactCategory {
	
	init?(json: JSON) {
		
		guard let categories = json["category"] as? [String] else {
			return nil
		}
		
		self.categories = categories
	}
}
