//
//  InfraStructureHandler.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class InfraStructureHandler {
	
	func verifySuccessStatusCode(_ response: HTTPURLResponse) throws {
		
		guard response.statusCode >= 200 && response.statusCode < 300 else {
			let serviceError = getError(for: response.statusCode)
			throw serviceError
		}
	}
	
	private func getError(for statusCode: Int) -> ServiceError {
		switch statusCode {
			
		case 400 ... 499:
			let badRequest = BadRequestError(code: statusCode)
			return .badRequest(badRequest)
		default:
			return .internalServer
		}
	}
}
