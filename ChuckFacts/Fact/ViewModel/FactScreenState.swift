//
//  FactScreenState.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import UIKit

enum FactScreenState {
	
	case loading(UIColor)
	case failure(FactScreenErrorType)
	case success([FactModel])
	case successWithEmptyResult
}

extension FactScreenState {
	
	init(badRequest error: BadRequestError) {
		switch error {
		case .noResults:
			self = .failure(.noResults)
		case .invalidTerm:
			self =  .failure(.invalidTerm)
		case .other:
			self = .failure(.unknown)
		}
	}
}

extension FactScreenState: Equatable {
	
	static func ==(lhs: FactScreenState, rhs: FactScreenState) -> Bool {
		switch (lhs, rhs) {
		case let (.loading(color), .loading(color2)):
			return color == color2
		case let (.failure(error), .failure(error2)):
			return error == error2
		case let (.success(facts), .success(facts2)):
			return facts == facts2
		case (.successWithEmptyResult, .successWithEmptyResult):
			return true
		default:
			return false
		}
	}
}
