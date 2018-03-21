//
//  SettingsOpenerMock.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 21/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

@testable import ChuckFacts
import Foundation

final class SettingsOpenerMock: SettingsOpenable {
	
	private(set) var isOpened = false
	
	func open() {
		isOpened = true
	}
}
