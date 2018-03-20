//
//  InternetConnectionHandlerMock.swift
//  ChuckFactsTests
//
//  Created by Calebe Emerik  | Stone on 15/03/18.
//  Copyright © 2018 Stone Pagamentos. All rights reserved.
//

import Foundation

final class InternetConnectionHandlerMock: InternetConnectionHandable {
	
	func verify(_ error: Error) throws {
		
		guard let urlError = error as? URLError.Code else {
			throw error
		}
		
		if urlError == .notConnectedToInternet {
			throw ServiceError.connection(.noConnection)
		}
		else if urlError == .timedOut {
			throw ServiceError.connection(.timeout)
		}
		else {
			throw ServiceError.connection(.other)
		}
	}
}
