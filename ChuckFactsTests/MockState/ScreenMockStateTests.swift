//
//  ScreenMockStateTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 19/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class ScreenMockStateTests: XCTestCase {
	
	private var mockState: ScreenMockState!
	
	private func getEnvironment(for state: FactServiceMock.FactScreenStateMock) -> [String: String] {
		return ["screen_mock_state": state.rawValue]
	}
	
	private func verifyEnvironment(for expectedState: FactServiceMock.FactScreenStateMock) {
		
		let environment = getEnvironment(for: expectedState)
		
		let result = mockState.getState(from: environment)
		
		expect(result) == expectedState
	}
	
	override func setUp() {
		super.setUp()
		
		mockState = ScreenMockState()
	}
	
	override func tearDown() {
		mockState = nil
		
		super.tearDown()
	}
	
	func test_State_ShouldBe_Success() {
		
		verifyEnvironment(for: .success)
	}
	
	func test_State_ShouldBe_SuccessWithEmptyResult() {
		
		verifyEnvironment(for: .successWithEmptyResult)
	}
	
	func test_State_ShouldBe_NoResultsForTerm() {

		verifyEnvironment(for: .noResultsForTerm)
	}
	
	func test_State_ShouldBe_InvalidTerm() {
		
		verifyEnvironment(for: .invalidTerm)
	}
	
	func test_State_ShouldBe_NoConnection() {
		
		verifyEnvironment(for: .noConnection)
	}
	
	func test_State_ShouldBe_Internal() {
		
		verifyEnvironment(for: .unknown)
	}
}
