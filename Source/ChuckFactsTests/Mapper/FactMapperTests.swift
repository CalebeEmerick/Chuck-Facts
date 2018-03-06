//
//  FactMapperTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactMapperTests: XCTestCase {
	
	private var mapper: FactMapper!
	
	private var validJSON: JSON {
		return [
			"total": 2,
			"result": [
				[
					"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
					"id": "tng5xzi5t9syvqaubukycw",
					"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
					"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
				],
				[
					"category": nil,
					"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
					"id": "DuhjnnJCQmKAeMECnYTJuA",
					"url": "https://api.chucknorris.io/jokes/DuhjnnJCQmKAeMECnYTJuA",
					"value": "Jack in the Box's do not work around Chuck Norris. They know better than to attempt to scare Chuck Norris"
				]
			]
		]
	}
	
	private var invalidJSON: JSON {
		return [
			"total": 1,
			"key": [
				[
					"category": nil,
					"icon_url": "https://assets.chucknorris.host/img/avatar/chuck-norris.png",
					"id": "tng5xzi5t9syvqaubukycw",
					"url": "https://api.chucknorris.io/jokes/tng5xzi5t9syvqaubukycw",
					"value": "Chuck Norris always knows the EXACT location of Carmen SanDiego."
				]
			]
		]
	}
	
	override func setUp() {
		super.setUp()
		
		mapper = FactMapper()
	}
	
	override func tearDown() {
		mapper = nil
		
		super.tearDown()
	}
	
	func test_shouldThrow_InvalidJSONError_When_InvalidJSONIsUsed() {
		
		expect {
			try self.mapper.map(self.invalidJSON)
			}.to(throwError { (error: FactMapper.FactsError) in
				expect(error).to(equal(FactMapper.FactsError.invalidJSON))
			})
	}
	
	func test_shouldNot_ThrowError_When_ValidJSONIsUsed() {
		
		expect {
			try self.mapper.map(self.validJSON)
			}.toNot(throwError())
	}
}
