//
//  Fact.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 01/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

struct Fact {
	
	let id: String
	let message: String
	let category: FactCategory?
}

extension Fact {
	
	enum FactError: Error {
		
		case missingId
		case missingMessage
	}
}

extension Fact {
	
	init(json: JSON) throws {
		
		guard let id = json["id"] as? String else {
			throw FactError.missingId
		}
		
		guard let message = json["value"] as? String else {
			throw FactError.missingMessage
		}
		
		let category = FactCategory(json: json)
		
		self.id = id
		self.message = message
		self.category = category
	}
}
