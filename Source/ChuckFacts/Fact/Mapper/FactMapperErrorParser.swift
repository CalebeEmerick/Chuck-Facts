//
//  FactMapperErrorParser.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class FactMapperErrorParser {
	
	func parse(_ error: Error) -> ServiceError {
		let modelParseError = JSONParseError.model
		let serviceError = ServiceError.JSONParse(modelParseError)
		return serviceError
	}
}
