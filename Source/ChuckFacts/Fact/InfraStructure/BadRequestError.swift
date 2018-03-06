//
//  BadRequestError.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 02/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum BadRequestError {
	
	case invalidTerm
	case notFound
	case other
	
	init(code: Int) {
		switch code {
		case 422:
			self = .invalidTerm
		case 404:
			self = .notFound
		default:
			self = .other
		}
	}
}
