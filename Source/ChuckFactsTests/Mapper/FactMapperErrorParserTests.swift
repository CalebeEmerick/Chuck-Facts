//
//  FactMapperErrorParserTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactMapperErrorParserTests: XCTestCase {
	
	private var parser: FactMapperErrorParser!
	
	override func setUp() {
		super.setUp()
		
		parser = FactMapperErrorParser()
	}
	
	override func tearDown() {
		parser = nil
		
		super.tearDown()
	}
	
	func test_serviceError_shouldBe_modelParse() {
		
		let invalidJSONError: Error = FactMapper.FactsError.invalidJSON
		
		let serviceError = parser.parse(invalidJSONError)
		
		if case let .JSONParse(error) = serviceError {
			expect(error).to(equal(JSONParseError.modelParse))
		}
		else {
			fail("Esperava-se ser erro de parse de JSON.")
		}
	}
}
