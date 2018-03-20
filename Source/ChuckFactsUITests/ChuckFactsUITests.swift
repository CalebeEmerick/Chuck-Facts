//
//  ChuckFactsUITests.swift
//  ChuckFactsUITests
//
//  Created by Calebe Emerik  | Stone on 15/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Nimble
import XCTest

final class ChuckFactsUITests: XCTestCase {
	
	private var app: XCUIApplication!
	private var screen: FactScreen!
	
	private func setScreenState(to state: String) {
		app.launchEnvironment.updateValue(state, forKey: "screen_mock_state")
	}
	
	private func searchSomeFactAndWaitFor(_ state: String) {
		setScreenState(to: state)
		
		app.launch()
		
		screen.textField.typeText("Some Fact...")
		screen.searchButton.tap()
	}
	
	override func setUp() {
		super.setUp()
		
		continueAfterFailure = false
		
		app = XCUIApplication()
		
		app.launchArguments.append("--uitesting")
		
		screen = FactScreen(app: app)
	}
	
	override func tearDown() {
		screen = nil
		app = nil
		
		super.tearDown()
	}
	
	func test_TextField_Should_BeEnabled_When_AppStarts() {
		
		setScreenState(to: "success")
		
		app.launch()
		
		expect(self.screen.textField.isEnabled).to(beTrue())
	}
	
	func test_SearchSomeFactWith_Success_AndShouldShow_AListWithTwoFacts() {
		
		searchSomeFactAndWaitFor("success")
		
		expect(self.screen.tableView.cells.count).toEventually(equal(2), timeout: 1)
	}
	
	func test_SearchSomeFactWith_SuccessWithEmptyResult_AndShow_EmptyResultView() {

		searchSomeFactAndWaitFor("successWithEmptyResult")

		expect(self.screen.emptyResult.exists).toEventually(beTrue(), timeout: 1)
	}
	
	func test_SearchSomeFactWith_NoResultsForTerm_AndShow_NoResultsForTermView() {
		
		searchSomeFactAndWaitFor("noResultsForTerm")
		
		expect(self.screen.emptyResult.exists).toEventually(beTrue(), timeout: 1)
	}
	
	func test_SearchSomeFactWith_InvalidTerm_AndShow_InvalidTermView() {
		
		searchSomeFactAndWaitFor("invalidTerm")
		
		expect(self.screen.invalidTerm.exists).toEventually(beTrue(), timeout: 1)
	}
	
	func test_SearchSomeFactWith_NoConnection_AndShow_NoConnectionView() {
		
		searchSomeFactAndWaitFor("noConnection")
		
		expect(self.screen.noConnection.exists).toEventually(beTrue(), timeout: 2)
	}
	
	func test_SearchSomeFactWith_InternalError_AndShow_InternalErrorView() {
		
		searchSomeFactAndWaitFor("internal")
		
		expect(self.screen.internalError.exists).toEventually(beTrue(), timeout: 1)
	}
}

extension ChuckFactsUITests {
	
	struct FactScreen {
		
		let textField: XCUIElement
		let searchButton: XCUIElement
		let tableView: XCUIElement
		let emptyResult: XCUIElement
		let invalidTerm: XCUIElement
		let noConnection: XCUIElement
		let internalError: XCUIElement
		
		init(app: XCUIApplication) {
			textField = app.textFields["FactTextField"]
			searchButton = app.keyboards.buttons["Search"]
			tableView = app.tables["FactTableView"]
			emptyResult = app.otherElements["FactEmptyResult"]
			invalidTerm = app.otherElements["FactInvalidTerm"]
			noConnection = app.otherElements["FactConnectionError"]
			internalError = app.otherElements["FactInternalError"]
		}
	}
}
