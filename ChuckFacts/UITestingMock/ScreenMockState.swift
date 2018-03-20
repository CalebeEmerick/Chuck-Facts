//
//  ScreenMockState.swift
//  ChuckFacts
//
//  Created by Calebe Emerik  | Stone on 19/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class ScreenMockState {
	
	private let kState: String
	
	init(stateKey: String = "screen_mock_state") {
		kState = stateKey
	}
	
	func getState(from environment: [String: String]) -> FactServiceMock.FactScreenStateMock {
		
		guard let stateString = environment[kState] else {
			fatalError("Não há nenhum estado dentro do `environment`.")
		}
		
		return FactServiceMock.FactScreenStateMock(state: stateString)
	}
}
