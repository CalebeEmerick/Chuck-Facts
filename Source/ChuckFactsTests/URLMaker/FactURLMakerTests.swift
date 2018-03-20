//
//  FactURLMakerTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerick on 06/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class FactURLMakerTests: XCTestCase {
	
	private var urlMaker: FactURLMaker!
	
	override func setUp() {
		super.setUp()
		
		urlMaker = FactURLMaker()
	}
	
	override func tearDown() {
		urlMaker = nil
		
		super.tearDown()
	}
	
	func test_ShouldConcat_BaseURL_With_Term() {
		
		let baseUrl = "https://api.chucknorris.io/jokes/search?query="
		let term = "business"
		
		let fullUrl = urlMaker.make(from: baseUrl, with: term)
		
		expect(fullUrl).to(equal(baseUrl + term))
	}
	
	func test_ShouldEncode_URL_ForQueryString() {
		
		let baseUrl = "https://api.chucknorris.io/jokes/search?query="
		let term = "some term"
		
		let fullUrl = urlMaker.make(from: baseUrl, with: term)
		let expectedUrl = "https://api.chucknorris.io/jokes/search?query=some%20term"
		
		expect(fullUrl).to(equal(expectedUrl))
	}
}
