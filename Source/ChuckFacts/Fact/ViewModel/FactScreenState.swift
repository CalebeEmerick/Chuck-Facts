//
//  FactScreenState.swift
//  ChuckFacts
//
//  Created by Calebe Emerick on 05/03/2018.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

enum FactScreenState {
	
	case loading
	case failure()
	case success([FactModel])
	case unexpectedError
}
