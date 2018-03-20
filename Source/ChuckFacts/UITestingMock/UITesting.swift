//
//  UITesting.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 19/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class UITesting {
	
	private let kTesting: String
	
	init(key: String = "--uitesting") {
		kTesting = key
	}
	
	func verifyRunningInTestMode(for arguments: [String]) -> Bool {
		return arguments.contains(kTesting)
	}
}
