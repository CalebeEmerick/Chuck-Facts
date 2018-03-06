//
//  JSONParseError.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 02/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum JSONParseError {
	
	case result
	case modelParse(String)
}

extension JSONParseError: Equatable {
	
	static func ==(lhs: JSONParseError, rhs: JSONParseError) -> Bool {
		switch (lhs, rhs) {
		case (let .modelParse(error), let .modelParse(error2)):
			return error == error2
		case (.result, .result):
			return true
		default:
			return false
		}
	}
}
