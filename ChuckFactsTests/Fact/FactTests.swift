//
//  FactTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactTests: XCTestCase {
	
	private var validJSON: JSON {
		return [
			"category": ["Money"],
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"id": "tng5xzi5t9syvqaubukycw",
			"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
			"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
		]
	}
	
	private var missingIdJSON: JSON {
		return [
			"category": ["Car"],
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
			"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
		]
	}
	
	private var missingValueJSON: JSON {
		return [
			"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
			"id": "tng5xzi5t9syvqaubukycw",
			"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw"
		]
	}
	
	func test_shouldNot_ThrowError_When_ValidJSONIsUsed() {
		
		expect {
			try Fact(json: self.validJSON)
		}.toNot(throwError())
	}
	
	func test_shouldThrow_MissingIdError_When_AJSONWithoutIdIsUsed() {
		expect {
			try Fact(json: self.missingIdJSON)
			}.to(throwError { (error: Fact.FactError) in
				expect(error).to(equal(Fact.FactError.missingId))
			})
	}
	
	func test_shouldThrow_MissingValueError_When_AJSONWithoutValueIsUsed() {
		expect {
			try Fact(json: self.missingValueJSON)
			}.to(throwError { (error: Fact.FactError) in
				expect(error).to(equal(Fact.FactError.missingMessage))
			})
	}
}
