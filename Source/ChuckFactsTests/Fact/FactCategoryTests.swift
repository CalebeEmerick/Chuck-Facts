//
//  FactCategoryTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactCategoryTests: XCTestCase {
	
	private var validJSON: JSON {
		return [
			"category": ["Money"],
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"id": "tng5xzi5t9syvqaubukycw",
			"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
			"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
		]
	}
	
	private var invalidJSON: JSON {
		return [
			"category": "Car",
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"id": "tng5xzi5t9syvqaubukycw",
			"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
			"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
		]
	}
	
	func test_shouldReturn_Nil_When_InvalidJSONIsUsed() {
		
		let nullableCategory = FactCategory(json: invalidJSON)
		
		expect(nullableCategory).to(beNil())
	}
	
	func test_shouldReturn_ValidObject_When_ValidJSONIsUsed() {
		
		let category = FactCategory(json: validJSON)
		
		expect(category).toNot(beNil())
	}
}
