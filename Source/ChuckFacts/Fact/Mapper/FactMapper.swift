//
//  FactMapper.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class FactMapper {
	
	enum FactsError: Error {
		
		case invalidJSON
		case other(String)
	}
	
	func map(_ json: JSON) throws -> [Fact] {
		
		guard let jsonList = json["result"] as? [JSON] else {
			throw FactsError.invalidJSON
		}
		
		var facts: [Fact] = []
		
		for json in jsonList {
			
			do {
				let fact = try Fact(json: json)
				facts.append(fact)
			}
			catch let error as Fact.FactError {
				throw error
			}
			catch {
				throw FactsError.other(error.localizedDescription)
			}
		}
		
		return facts
	}
}

extension FactMapper.FactsError: Equatable {
	
	static func ==(lhs: FactMapper.FactsError, rhs: FactMapper.FactsError) -> Bool {
		switch (lhs, rhs) {
		case (let .other(message), let .other(message2)):
			return message == message2
		case (.invalidJSON, .invalidJSON):
			return true
		default:
			return false
		}
	}
}
