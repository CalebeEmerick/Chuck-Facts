//
//  ConnectionErrorViewModelTests.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 21/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Nimble
import XCTest

final class ConnectionErrorViewModelTests: XCTestCase {
	
	private var viewModel: ConnectionErrorViewModel!
	private var settingsOpener: SettingsOpenerMock!
	
	override func setUp() {
		super.setUp()
		
		settingsOpener = SettingsOpenerMock()
		viewModel = ConnectionErrorViewModel(settings: settingsOpener)
	}
	
	override func tearDown() {
		viewModel = nil
		settingsOpener = nil
		
		super.tearDown()
	}
	
	func test_ShouldCall_OpenMethod_InSettingsOpenerMock_When_OpenSettings_IsCalled() {
		
		viewModel.openSettings()
		
		expect(self.settingsOpener.isOpened).to(beTrue())
	}
}
