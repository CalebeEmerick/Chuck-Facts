//
//  UITestingTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 19/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class UITestingTests: XCTestCase {
	
	private var testing: UITesting!
	
	override func setUp() {
		super.setUp()
		
		testing = UITesting()
	}
	
	override func tearDown() {
		testing = nil
		
		super.tearDown()
	}
	
	func test_ShouldBe_RunningInTestMode() {
		
		let arguments = ["tst", "--uitesting", "asdsda", "lol"]
		
		let isRunningInTestMode = testing.verifyRunningInTestMode(for: arguments)
		
		expect(isRunningInTestMode).to(beTrue())
	}
}
