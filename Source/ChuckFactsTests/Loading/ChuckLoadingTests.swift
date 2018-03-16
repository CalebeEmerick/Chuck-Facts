//
//  ChuckLoadingTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 16/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class ChuckLoadingTests: XCTestCase {
	
	private var view: ChuckLoading!
	
	override func setUp() {
		super.setUp()
		
		view = ChuckLoading()
	}
	
	override func tearDown() {
		view = nil
		
		super.tearDown()
	}
	
	func test_Loading_ShouldStart_Stopped() {
		
		expect(self.view.isLoading).to(beFalse())
	}
	
	func test_Loading_ShouldBe_Animating_When_ShowLoadingIsCalled() {
		
		view.showLoading()
		
		expect(self.view.isLoading).toEventually(beTrue())
	}
	
	func test_Loading_ShouldStopAnimating_When_HideLoadingIsCalled() {
		
		view.showLoading()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.view.hideLoading()
		}
		
		expect(self.view.isLoading).toEventually(beFalse(), timeout: 1)
	}
}
